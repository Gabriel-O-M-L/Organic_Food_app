from django.urls import path

from Seller.views import SellerView

urlpatterns = [

    path('create/', SellerView.as_view({
        'post': 'create'
    })),
    path('delete/', SellerView.as_view({
        'delete': 'delete'
    })),
    path('search/', SellerView.as_view({
        'get': 'search'
    }))

]