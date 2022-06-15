from django.urls import path

from recommendation.views import RegisterView

urlpatterns = [
    path('recommend/', RegisterView.as_view({
        'post': 'recommendCloser'
    })),
    path('rate/', RegisterView.as_view({
        'post': 'create'
    })),
]