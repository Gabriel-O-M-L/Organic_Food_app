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
    path('rate/', ProductView.as_view({
        'post': 'addRating'
    })),
    path('search/', ProductView.as_view({
        'post': 'search'
    })),
    path('seller/', ProductView.as_view({
        'post': 'seller'
    })),
    path('myproduct/', ProductView.as_view({
        'post': 'myproducts'
    }))
]