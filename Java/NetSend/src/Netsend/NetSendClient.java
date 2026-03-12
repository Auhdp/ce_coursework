package Netsend;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;

public class NetSendClient {
    private JFrame frame;
    private JTextField ipAddressField;
    private JTextField messageField;
    private JComboBox<String> destinationComboBox;

    public NetSendClient() {
        frame = new JFrame("Net Send Client");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 150);

        JPanel panel = new JPanel(new GridLayout(4, 1));

        JLabel destinationLabel = new JLabel("Đích:");
        String[] destinationOptions = {"IP", "Group", "*"};
        destinationComboBox = new JComboBox<>(destinationOptions);

        JLabel ipAddressLabel = new JLabel("IP/Group:");
        ipAddressField = new JTextField();

        JLabel messageLabel = new JLabel("Tin nhắn:");
        messageField = new JTextField();

        JButton sendButton = new JButton("Gửi");
        sendButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                sendMessage();
            }
        });

        panel.add(destinationLabel);
        panel.add(destinationComboBox);
        panel.add(ipAddressLabel);
        panel.add(ipAddressField);
        panel.add(messageLabel);
        panel.add(messageField);
        panel.add(sendButton);

        frame.add(panel);
        frame.setVisible(true);
    }

    private void sendMessage() {
        String destinationType = (String) destinationComboBox.getSelectedItem();
        String destination = ipAddressField.getText();
        String message = messageField.getText();

        try {
            InetAddress serverAddress = InetAddress.getByName(destination);
            int serverPort = 12345; // Cổng để kết nối với máy nhận

            Socket socket = new Socket(serverAddress, serverPort);

            // Gửi tin nhắn tới máy nhận
            OutputStream out = socket.getOutputStream();
            PrintWriter writer = new PrintWriter(out, true);
            writer.println(destinationType + " " + message);

            // Đóng kết nối
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                new NetSendClient();
            }
        });
    }
}
