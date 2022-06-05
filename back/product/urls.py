from django.urls import path

from product.views import ProductView

urlpatterns = [
    path('create/', ProductView.as_view({
        'post': 'create'
    })),
    path('rate/', ProductView.as_view({
        'post': 'addRating'
    })),
    path('show/', ProductView.as_view({
        'post': 'showProducts'
    })),
    path('recommend/', ProductView.as_view({
        'get': 'recommendCloser'
    })),
    path('delete/', ProductView.as_view({
        'delete': 'delete'
    })),
    path('search/', ProductView.as_view({
        'get': 'search'
    }))
]