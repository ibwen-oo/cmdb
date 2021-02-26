from django.shortcuts import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response

from cmdbapi.utils import process


class Server(APIView):
    """服务器"""
    def get(self, request, *args, **kwargs):
        return HttpResponse(1111)

    def post(self, request, *args, **kwargs):
        server_base_info = request.data["sysinfo"]
        server_disk_info = request.data["disk"]

        process_server = process.ProcessServerInfo(server_base_info, server_disk_info)
        process_server.process_server()
        process_server.process_network()
        process_server.process_disk()

        return Response("121212")
