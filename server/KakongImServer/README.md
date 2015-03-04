Kakong IM Server
=======================

Performance: Tested on VM: OS: CentOS, 4vCPU, 2GB RAM,Java 7

Client Sessions:

can support:

10,000 long-polling sessions on single node
50,000 WebSocket sessions on single node

TPS:

4,000 requests per second per single channel.
80,000 requests per second total.
KakongIMServer is a simple Socket.IO Java server implementation based on Netty server framework. Supports 0.7+ up to latest 0.9.16 versions of Socket.IO-client.

Supported transport protocols:

WebSocket
Flash Socket
XHR-Polling
JSONP-Polling
How to use

    SocketIOServer socketIoServer = new SocketIOServer();
    socketIoServer.setPort(5000);
    socketIoServer.setListener(new SocketIOAdapter() {
        public void onMessage(ISession session, ByteBuf message) {
            System.out.println("Received: " + message.toString(CharsetUtil.UTF_8));
            message.release();
        }
    });
    socketIoServer.start();