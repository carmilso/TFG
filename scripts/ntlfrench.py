schu=["","un ","deux ","trois ","quatre ","cinq ","six ","sept ","huit ","neuf "]
schud=["dix ","onze ","douze ","treize ","quatorce ","quinze ","seize ","dix-sept ","dix-huit ","dix-neuf "]
schd=["","dix ","vingt ","trente ","quarente ","cinquante ","soixante ","soixante ","quatre-vingt ","quatre-vingt "]
def convNombre2lettres(nombre):
    s=''
    reste=nombre
    i=1000000000 
    while i>0:
        y=reste/i
        if y!=0:
            centaine=y/100
            dizaine=(y - centaine*100)/10
            unite=y-centaine*100-dizaine*10
	    #print centaine,dizaine,unite	
            if centaine==1:
                s+="cent "
            elif centaine!=0:
                s+=schu[centaine]+"cent "
                if dizaine==0 and unite==0: s=s[:-1]+"s " 
            if dizaine not in [0,1]: s+=schd[dizaine] 
            if unite==0:
                if dizaine in [1,7,9]: s+="dix "
                elif dizaine==8: s=s[:-1]+"s "
            elif unite==1:   
                if dizaine in [1,9]: s+="onze "
                elif dizaine==7: s+="et onze "
                elif dizaine in [2,3,4,5,6]: s+="et un "
                elif dizaine in [0,8]: s+="un "
            elif unite in [2,3,4,5,6,7,8,9]: 
                if dizaine in [1]: s+=schud[unite] 
		elif dizaine in [7,9]: s=s[:-1]+"-"+schud[unite] 
                elif dizaine in [0]: s+=schu[unite]
		else: s=s[:-1]+"-"+schu[unite] 
            if i==1000000000:
                if y>1: s+="milliards "
                else: s+="milliard "
            if i==1000000:
                if y>1: s+="millions "
                else: s+="millions "
            if i==1000:
                s+="mille "
        #end if y!=0
        reste -= y*i
        dix=False
        i/=1000;
    #end while
    if len(s)==0: s+="cero "
    return s


