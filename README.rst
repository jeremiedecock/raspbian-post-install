=============================
Raspbian post-install scripts
=============================

Copyright (c) 2014,2015,2016 Jeremie DECOCK (http://www.jdhp.org)

* Source code: https://github.com/jeremiedecock/raspbian-post-install
* Issue tracker: https://github.com/jeremiedecock/raspbian-post-install/issues


Description
===========

This repository contains a collection of scripts to automate and make easier
the Raspbian post-install tasks.

Note:

    This project is still in beta stage.


Install
=======

After a fresh install, log into the console:

- user: pi
- password: raspberry
  
Warning: at this stage the system assume you use an US keyboard ; thus you have
to adapt the user/password to your keyboard (e.g. on French keyboard type
"rqspberry" instead).

Then download the install script::

    wget www.jdhp.org/dl/rpi.sh

(``zget zzz:jdhp:org!dl!rpi:sh`` on French keyboard)

And finally launch it (with root privileges)::

    sudo bash rpi.sh

(``sudo bqsh rpi:sh`` on French keyboard)

.. Install git::
.. 
..     apt-get update
..     apt-get install git
.. 
.. (``qpt)get updqte`` and ``qpt)get inst)ll git`` on French keyboard)
.. 
.. Install *raspbian post-install scripts*::
.. 
..     git clone --recursive https://github.com/jeremiedecock/raspbian-post-install.git
.. 
.. (``git clone ))recursive httpsM!!github:co,!jere,iedecock!rqspbiqn)post)instqll:git`` on French keyboard)
.. 
.. Launch *raspbian post-install scripts*::
.. 
..     cd raspbian_post_install
..     ./install.sh
.. 
.. (``cd rqspbiqn°post°instqll`` and ``:!instqll:sh`` on French keyboard)

.. TODO: use short urls (defined through .htaccess) in http://jdhp.org/ e.g. http://jdhp.org/rpi.git or http://jdhp.org/1


Bug reports
===========

To search for bugs or report them, please use the following Bug Tracker:

    https://github.com/jeremiedecock/raspbian-post-install/issues


License
=======

This project is provided under the terms and conditions of the `MIT License`_.

.. _MIT License: http://opensource.org/licenses/MIT

