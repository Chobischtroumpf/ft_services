<?php

$cfg['blowfish_secret'] = '$2a$07$EJooQ7FWQIpYWJAMqd0mq.eRnrTTAkqpIwEv1InrJ8q0KMfAK0WLi'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

$i = 0;

$i++;

/* Authentication type */

$cfg['Servers'][$i]['auth_type'] = 'cookie';

/* Server parameters */

$cfg['Servers'][$i]['host'] = 'mysql';
$cfg['Servers'][$i]['port'] = 3306;
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
$cfg['Servers'][$i]['extension'] = 'mysqli';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';