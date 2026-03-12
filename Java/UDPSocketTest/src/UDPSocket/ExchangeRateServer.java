package UDPSocket;

import java.io.*;
import java.net.*;
import java.util.*;

public class ExchangeRateServer {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter port (nnn): ");
        int port = 10000 + scanner.nextInt();
        scanner.close();

        try (DatagramSocket serverSocket = new DatagramSocket(port)) {
            System.out.println("ExchangeRateServer running " + port);
            
            while (true) {
                byte[] receiveData = new byte[1024];
                DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                serverSocket.receive(receivePacket);

                InetAddress clientAddress = receivePacket.getAddress();
                int clientPort = receivePacket.getPort();

                Random random = new Random();
                double tokyoRate = random.nextDouble() * 100.5;
                double newYorkRate = random.nextDouble() * 100.3;
                double hongKongRate = random.nextDouble() * 100.1;
                String updateTime = new Date().toString();

                String response = String.format("Tỉ giá Tokyo: %.2f\nTỉ giá New York: %.2f\nTỉ giá Hồng Kông: %.2f\nCập nhật lúc: %s", tokyoRate, newYorkRate, hongKongRate, updateTime);
                byte[] sendData = response.getBytes();
                DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, clientAddress, clientPort);
                serverSocket.send(sendPacket);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
