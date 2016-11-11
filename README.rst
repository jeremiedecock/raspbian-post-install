================================
`Raspbian post-install scripts`_
================================

Copyright (c) 2014,2015 Jeremie DECOCK (http://www.jdhp.org)

* Source code: https://github.com/volab/raspbian_post_install
* Issue tracker: https://github.com/volab/raspbian_post_install/issues

In collaboration with http://www.vorobotics.com


Description
===========

`Raspbian post-install scripts`_ is a collection of open source .

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

Get root privileges::

    sudo -i

(``sudo )i`` on French keyboard)

Install git::

    apt-get update
    apt-get install git

(``qpt)get updqte`` and ``qpt)get inst)ll git`` on French keyboard)

Install *raspbian post-install scripts*::

    git clone --recursive https://github.com/jeremiedecock/raspbian-post-install.git

(``git clone ))recursive httpsM!!github:co,!jere,iedecock!rqspbiqn)post)instqll:git`` on French keyboard)

.. TODO: use short urls (defined through .htaccess) in http://jdhp.org/ e.g. http://jdhp.org/rpi.git or http://jdhp.org/1


Bug reports
===========

To search for bugs or report them, please use the following Bug Tracker:

    https://github.com/volab/raspbian_post_install/issues


License
=======

`Raspbian post-install scripts`_ are provided under the terms and conditions of
the `MIT License`_.


.. _MIT License: http://opensource.org/licenses/MIT

.. _Raspbian post-install scripts: https://github.com/volab/raspbian_post_install

