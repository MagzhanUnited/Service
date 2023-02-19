from django.urls import path
from . import views

urlpatterns = [
    path('getPersons/', views.getPersons),
    path('getPerson/<str:email>/<str:password>/', views.getPerson),
    path('create/person/', views.createPerson),
    path('create/product/', views.createProduct),
    path('getProducts/', views.getProducts),
    path('getPersonID/<str:id>/', views.getPersonID),
    path('getPersonalProducts/<str:id>/', views.getPersonalPruduct),
    path('deleteProduct/<str:pk>/', views.productDelete),
    path('update/likes/<str:pk>/', views.liking),
    path('update/views/<str:pk>/', views.views),
    path('getProduct/<str:id>/', views.getProduct),
    path('postMessage/', views.postMessage),
    path('getMessages/<str:id>/', views.getMessages),
    path('editingProduct/', views.editingProduct),
    path('bestProduct/', views.theBest),
    path('searchingProduct/<str:cartype>/<str:words>/', views.searchingProduct),
    path('postPersonMessage/', views.postPesronMessage),
    path('getPersonMessage/<str:id1>/<str:id2>/', views.getPersonMessages)
]