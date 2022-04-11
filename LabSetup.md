The lab contains: 
 - 3 Linux - Debian servers
 - 1 Windows Server

**There is a slight cost associated with the AWS resources**

[This link](https://philkeeble.com/automation/windows/activedirectory/AWS-RedTeam-ADLab-Setup/) does an excelllent job of showing how to get started with ahome lab quickly on a windows host - other OSs will require more research. 

I made some edits to the two main .tf files to give a more Linux focused lab since Hyprspace's windows support is a bit lacking. I'll attach mine and you can use those if you prefer. 

Once the Linux boxes are spun up Hyprspace will be installed by default. There are some configurations that have ot be done at that point.

# Configure the interfaces
Run the following command once on each linux box
![image](https://user-images.githubusercontent.com/86580417/162656233-373902c9-2b6d-4d46-8aee-5ee21b88c34a.png)
This will display the config file for the node created on the device

![image](https://user-images.githubusercontent.com/86580417/162656336-3d07f3fb-0d55-4a95-ba2e-a2cbf7b9c190.png)

This should be changed for each node. For example, the following images are the setups for 3 individual nodes: 
![hs1-1-e](https://user-images.githubusercontent.com/86580417/162657427-c6f2462d-64d4-4c36-b1d7-264a592298d4.png)
![hs1-2-e](https://user-images.githubusercontent.com/86580417/162657433-4b3f5c9b-64fa-4085-a947-b45dbd465ecf.png)
![hs1-3-e](https://user-images.githubusercontent.com/86580417/162657487-811140dc-935e-498f-aa1b-352153a1c899.png)

# Bring the Interface Up
Run the following command and you should receive a similar output
![image](https://user-images.githubusercontent.com/86580417/162657641-22ed55dc-7250-40ca-afa2-481810c027c0.png)
