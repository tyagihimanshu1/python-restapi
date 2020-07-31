from WordsApi import views
from django.urls import path,include
urlpatterns = [
    path('replaceWords/',views.ReplaceWords.as_view(),name='replace-words'),
]