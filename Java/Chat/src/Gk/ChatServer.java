package Gk;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.List;

public class ChatServer{
    private int port;
    private List<ClientInfo> clients = new ArrayList<>();
    private JTextArea chatArea;

    public ChatServer(int port) {
        this.port = port;

        JFrame frame = new JFrame("Chat Server");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);
        frame.setLayout(new BorderLayout());

        chatArea = new JTextArea();
        chatArea.setEditable(false);
        frame.add(new JScrollPane(chatArea), BorderLayout.CENTER);

        JButton startButton = new JButton("Start Server");
        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                startServer();
                startButton.setEnabled(false);
            }
        });
        frame.add(startButton, BorderLayout.NORTH);

        frame.setVisible(true);
    }

    private void startServer() {
        try {
            ServerSocket serverSocket = new ServerSocket(port);
            chatArea.append("Server đang lắng nghe ở cổng " + port + "\n");

            while (true) {
                Socket clientSocket = serverSocket.accept();

                // Cho phép người dùng đặt tên khi kết nối
                String username = JOptionPane.showInputDialog("Nhập tên người dùng cho " + clientSocket.getInetAddress().getHostAddress() + ":");
                ClientInfo clientInfo = new ClientInfo(clientSocket, username);
                clients.add(clientInfo);

                chatArea.append(username + " đã kết nối từ: " + clientSocket.getInetAddress().getHostAddress() + "\n");

                // Tạo một luồng riêng cho từng client
                Thread clientThread = new ClientThread(clientInfo);
                clientThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private class ClientThread extends Thread {
        private ClientInfo clientInfo;

        public ClientThread(ClientInfo clientInfo) {
            this.clientInfo = clientInfo;
        }

        @Override
        public void run() {
            try {
                BufferedReader in = new BufferedReader(new InputStreamReader(clientInfo.getSocket().getInputStream()));
                String message;

                while ((message = in.readLine()) != null) {
                    chatArea.append(clientInfo.getUsername() + ": " + message + "\n");

                    // Gửi tin nhắn đến tất cả các client khác
                    synchronized (clients) {
                        for (ClientInfo client : clients) {
                            if (client != clientInfo) {
                                PrintWriter clientOut = new PrintWriter(client.getSocket().getOutputStream(), true);
                                clientOut.println(clientInfo.getUsername() + ": " + message);
                            }
                        }
                    }
                }

                // Xóa client khi ngắt kết nối
                synchronized (clients) {
                    clients.remove(clientInfo);
                }

                chatArea.append(clientInfo.getUsername() + " đã ngắt kết nối từ: " + clientInfo.getSocket().getInetAddress().getHostAddress() + "\n");
                clientInfo.getSocket().close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                String portString = JOptionPane.showInputDialog("Nhập cổng (nn):");
                int port = Integer.parseInt(portString);
                new ChatServer(port);
            }
        });
    }

    private class ClientInfo {
        private Socket socket;
        private String username;

        public ClientInfo(Socket socket, String username) {
            this.socket = socket;
            this.username = username;
        }

        public Socket getSocket() {
            return socket;
        }

        public String getUsername() {
            return username;
        }
    }
}

