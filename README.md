
This is just an excuse to demo some useful tricks with Makefiles.  This code goes along with the Hackaday article ["Embed with Elliot: ARM Makefile Madness"](http://wp.me/pk3lN-PcD), so you should probably give that a look and then come back here.

To make this project work, as is, you'll need to modify the Makefile to point at your local installations of the CMSIS and STM32F4 HAL libraries. (Moving the libraries out of the project directory was basically the point of the article.) 

## Shout-outs

Check out the [ARM-programming workshop](https://github.com/muccc/arm-workshop).  Except for the Makefile, I basically copied everything straight from that project.  That should compile for you straight out of the gate.

## Going Further?

If you're looking for getting-started-with-STM32 templates, root around in my repositories and keep an eye on [my column at Hackaday](http://hackaday.com/?s=embed+with+elliot).  If people show enough interest, I'll do a series of articles on intro-ARM stuff.  (I might even if there isn't.)

