package Netsend;

import java.io.*;
import java.net.*;

public class NetSendServer {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Sử dụng: NetSendServer <port>");
            return;
        }

        int port = Integer.parseInt(args[0]);

        try {
            ServerSocket serverSocket = new ServerSocket(port);
            System.out.println("Đang lắng nghe trên cổng " + port);

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Kết nối từ: " + clientSocket.getInetAddress().getHostAddress());

                BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                String message = reader.readLine();
                System.out.println("Nhận tin nhắn: " + message);

                // Xử lý tin nhắn ở đây (ví dụ: hiển thị trên màn hình)

                clientSocket.close();
            }
        } catch (IOException e) {
            System.err.println("Lỗi khi lắng nghe kết nối.");
        }
    }
}
