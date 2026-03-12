package Netsend;

import java.io.*;
import java.net.*;

public class NetSend {
    public static void main(String[] args) {
        if (args.length != 3) {
            System.out.println("Sử dụng: netsend <IP | group | *> <port> <message>");
            return;
        }

        String target = args[0];
        int port = Integer.parseInt(args[1]);
        String message = args[2];

        try {
            InetAddress address = InetAddress.getByName(target);
            Socket socket = new Socket(address, port);

            OutputStream os = socket.getOutputStream();
            PrintWriter writer = new PrintWriter(os, true);
            writer.println(message);

            socket.close();
        } catch (UnknownHostException e) {
            System.err.println("Không thể tìm thấy địa chỉ IP của máy tính đích.");
        } catch (IOException e) {
            System.err.println("Lỗi khi gửi tin nhắn.");
        }
    }
}
