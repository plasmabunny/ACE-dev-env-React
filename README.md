# ACE-dev-env-React
This is a vagrantfile to setup a virtual development environment for React/meteor development intended for students of the Red River College ACE Project Space.

For ease of file editing, it has been configured with a samba server file share pointed at the /home/vagrant folder.  Samba was selected due to the issues with file locks that vagrant's native shared folder feature.  Since most students use Windows in our college program, SMB was the most sensible choice.

<h2> Instructions: </h2>
<ol>
  <li>Install <a href="https://www.virtualbox.org/">Virtualbox</a>.</li>
  <li>Install <a href="https://www.vagrantup.com/">Vagrant</a>.</li>
  <li>Pull this repo's contents and put them in a folder of your choice (referred to as <b>vagrantbox folder</b>), I use c:\VagrantBoxes\AceDevBox on my Windows computer.  These contents should include the following files: <b>Vagrantfile</b>, <b>samba-public-share.bash</b></li>
  <li>Open a commandline or powershell prompt and navigate to the <b>vagrantbox folder</b></li>
  <li>Enter the command <b>vagrant up</b>  This will create/provision a VM using the settings contained in the <b>vagrantfile</b></li>
  <li>Once provisioning is completed, you will be able to use the command <b>vagrant ssh</b> to connect to the virtual machine via an SSH connection and send bash commands to the linux virtual machine.</li>
  <li>
    Once connected to the vagrant VM via vagrant ssh, you can start creating apps:
    <ul>
      <li>Instructions to create a Meteor app can be found <a href="https://www.meteor.com/tutorials/blaze/creating-an-app">here.</a></li>
      <li>Instructions to create a React app can be found <a href="https://reactjs.org/docs/create-a-new-react-app.html">here.</a></li>
    </ul>
  </li>
  <li>The Samba server is accessible at file://55.55.55.5/Home via your host computer's File Explorer.  Windows hosts have a Samba/SMB client built in.  Configuring a non-Windows machine with a Samba/SMB client is beyond the scope of this document.</li>
</ol>
