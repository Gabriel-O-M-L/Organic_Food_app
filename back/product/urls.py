from django.urls import path

from product.views import ProductView

urlpatterns = [
    path('create/', ProductView.as_view({
        'post': 'create'
    })),
    path('show/', ProductView.as_view({
        'post': 'showProducts'
    })),
    path('delete/', ProductView.as_view({
        'delete': 'delete'
    })),
    path('search/', ProductView.as_view({
        'get': 'search'
    })),
    path('seller/', ProductView.as_view({
        'get': 'seller'
    }))
]