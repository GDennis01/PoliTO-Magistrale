Generalmente è preferibile usare gli *interrupt* per eventi esterni, dal momento che è *time efficient* e *power efficient*.
Tuttavia in alcuni casi non è possibile usarli e bisogna dunque usare il sistema di polling.
![[polling.png]]
Il polling controlla a intervalli regolari(tramite timer ad esempio) lo stato del device esterno.
Dunque la latenza è in base a quanto è frequente il *polling*, ovvero il check sul device esterno.
Più aumentiamo la frequenza, più diminuiamo la latenza e più aumentiamo il consumo elettrico, visto che la CPU dovrà svegliarsi da uno stato di idle più frequentemente(in caso implementassimo il polling tramite timer)

### Approccio con Timer
Usiamo un timer per triggerare una *interrupt* ad intervalli regolari.
Ogni volta che la CPU si sveglia, controlla il device esterno(*polling*).
Una volta finito il *polling*, il sistema ritorna a dormire e il timer riparte.

### JoyStick
Il JoyStick presente sulla LandTiger LPC17XX non può generare degli *interrupt* a causa dei suoi **pin** che non possiedono le capacità adatte.
Questi **pin** dunque bisogna usarli come **GPIO** e *pollare* ogni volta i valori.
Nello specifico, i pin, quando sono attivi, sono a 0 e operano sulla porta GPIO 1.
![[joystick_code.png]]
*Codice per gestire la pressione del joystick(tasto centrale).
In caso in cui la pressione del tasto si prolunghi per più tempo, nessuna azione verrà eseguita*