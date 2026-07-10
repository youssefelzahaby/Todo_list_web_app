from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from rest_framework_simplejwt.tokens import RefreshToken

from .serializers import RegisterSerializer, LoginSerializer



############################### user views ############################
############################ login and register #######################
@api_view(['POST'])
def register(request):
    serializer = RegisterSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()
        return Response({"message": "User created successfully"}, status=201)

    return Response(serializer.errors, status=400)
    



@api_view(['POST'])
def login(request):

    serializer = LoginSerializer(data=request.data)

    if serializer.is_valid():

        user = serializer.validated_data['user']

        refresh = RefreshToken.for_user(user)

        return Response({
            "access": str(refresh.access_token),
            "refresh": str(refresh)
        })

    return Response(
        serializer.errors,
        status=status.HTTP_400_BAD_REQUEST
    )


