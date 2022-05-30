from django.urls import path

from Seller.views import SellerView

urlpatterns = [

    path('create_seller/', SellerView.as_view({
        'post': 'create'
    })),

]