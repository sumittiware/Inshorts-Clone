# Inshorts clone

The Full Stack Clone of the popular News App in India

# Front End (Flutter Application)
## Features

- Dark Mode
- Multi Language Support [ English, हिंदी ]
- Share News Card As Image
- Offline Read
- Watermark on shared news card
- Webview


## Packages Used

- flutter_bloc & Dio : for http Request Handling.
- Provider : for State Management.
- Hive : for Local Strorage Management.
- share_plus : for Sharing News card.
- webview_flutter : web view inside the app.
- photo_view : gives extra features like image scaling.


# Backend (Django-Rest-Framekwork)

Inshorts website webscrapper server developed using Django-Rest-Framework

## Note:
    - If you are test it for an android device then use command python manage.py runserver 0.0.0.0:8000
    - Add your machines IP address in allowed hosts in setting.py file

## Endpoints : 
    /api/?lang=en&category=all;
    -lang is language locale (en, hi)
    -category (all categories avaliable in inshorts app)

### Demo Video
