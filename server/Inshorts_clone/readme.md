##Inshorts webscrapper server
    Webscrapper server developed using Django-Rest-Framework
#How to test:
    - Clone the repository install the packages in Pipfile.
    - Run the command python manage.py runserver
    - if you are test it for an android device then use command python manage.py runserver 0.0.0.0:8000
    - Add your machines IP address in allowed hosts in setting.py file

Endpoints : 
    /api/?lang=en&category=all;
    -lang is language locale (en, hi)
    -category (all categories avaliable in inshorts app)

