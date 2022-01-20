# from django.shortcuts import render

# Create your views here.
from rest_framework import status
from rest_framework.decorators import api_view
from django.http import JsonResponse
import requests
from bs4 import BeautifulSoup

@api_view(['GET'])
def get_news(request):
    category = request.query_params.get("category");
    language = request.query_params.get("lang");
    # dictonary that will hold the news
    data = []
    try:
        if category!='all':
            htmlBody = requests.get(F'https://www.inshorts.com/{language}/read/{category}')
        else:
            htmlBody = requests.get(F'https://www.inshorts.com/{language}/read')
    except requests.exceptions.RequestException as e:
        return JsonResponse({
            "error":{
                "status":status.HTTP_403_FORBIDDEN,
                "message": str(e)
            }          
        })

    soup = BeautifulSoup(htmlBody.text,'lxml')
    newsCards = soup.find_all(class_='news-card')

    if not newsCards:
        print("HEre")
        return JsonResponse({
            "error":{
                "status":status.HTTP_404_NOT_FOUND,
                "message":"No Data found"
            }          
        })

    for index,card in enumerate(newsCards):

        try:
            title = card.find(class_='news-card-title').find('a').text.strip()
        except AttributeError:
            title=""
        
        try:
            imageUrl = card.find(
                class_='news-card-image')['style'].split("'")[1]
        except AttributeError:
            imageUrl = None

        try:
            url = ('https://www.inshorts.com' + card.find(class_='news-card-title')
                   .find('a').get('href'))
        except AttributeError:
            url = None

        try:
            content = card.find(class_='news-card-content').find('div').text
        except AttributeError:
            content = None

        try:
            author = card.find(class_='author').text
        except AttributeError:
            author = None

        try:
            date = card.find(clas='date').text
        except AttributeError:
            date = None

        try:
            time = card.find(class_='time').text
        except AttributeError:
            time = None

        try:
            readMoreUrl = card.find(class_='read-more').find('a').get('href')
        except AttributeError:
            readMoreUrl = None

        newsObject = {
            'title': title,
            'imageUrl': imageUrl,
            'url': url,
            'content': content,
            'author': author,
            'date': str(date),
            'time': str(time),
            'readMoreUrl': readMoreUrl
        }

        data.append(newsObject)
    
    return JsonResponse({
        "status":status.HTTP_200_OK,
        "totalResults":len(data),
        "articles":data
    })
        
