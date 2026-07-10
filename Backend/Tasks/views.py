from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import (
    api_view,
    permission_classes
)
from Tasks.models import Task
from Tasks.serializers import TaskSerializer
from rest_framework.response import Response
from rest_framework import status
######################### get_tasks view function #########################

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_tasks(request):

    tasks = Task.objects.filter(
        user=request.user
    )

    serializer = TaskSerializer(
        tasks,
        many=True
    )

    return Response(serializer.data)


######################### create_task view function ######################### 

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_task(request):

    serializer = TaskSerializer(
        data=request.data
    )

    

    if serializer.is_valid():

        serializer.save(
            user=request.user
        )

        return Response(
            serializer.data,
            status=status.HTTP_201_CREATED
        )

    return Response(
        serializer.errors,
        status=status.HTTP_400_BAD_REQUEST
    )

 
 ########################## update_task view function #########################
 
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_task(request, pk):

    try:
        task = Task.objects.get(
            id=pk,
            user=request.user
        )

    except Task.DoesNotExist:
        return Response(
            {"error": "Task not found"},
            status=status.HTTP_404_NOT_FOUND
        )

    serializer = TaskSerializer(
        task,
        data=request.data
    )

    if serializer.is_valid():

        serializer.save()

        return Response(serializer.data)

    return Response(
        serializer.errors,
        status=status.HTTP_400_BAD_REQUEST
    )

########################## delete_task view function #########################


@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_task(request, pk):

    try:
        task = Task.objects.get(
            id=pk,
            user=request.user
        )

    except Task.DoesNotExist:
        return Response(
            {"error": "Task not found"},
            status=status.HTTP_404_NOT_FOUND
        )

    task.delete()

    return Response({
        "message": "Task deleted"
    })