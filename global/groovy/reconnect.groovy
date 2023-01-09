import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*
import hudson.node_monitors.*
import hudson.slaves.*
import java.util.concurrent.*

jenkins = Jenkins.instance

def getEnviron(computer) {
   def env
   def thread = Thread.start("Getting env from ${computer.name}", { env = computer.environment })
   thread.join(2000)
   if (thread.isAlive()) thread.interrupt()
   env
}

def agentAccessible(computer) {
    getEnviron(computer)?.get('PATH') != null
}

def numberOfflineNodes = 0
def numberNodes = 0
for (agent in jenkins.getNodes()) {
   def computer = agent.computer
   numberNodes ++
   println ""
   println "Checking computer ${computer.name}:"
   def isOK = (agentAccessible(computer) && !computer.offline)
   if (isOK) {
     println "\t\tOK, got PATH back from agent ${computer.name}."
     println('\tcomputer.isOffline: ' + computer.isOffline());
     println('\tcomputer.isTemporarilyOffline: ' + computer.isTemporarilyOffline());
     println('\tcomputer.getOfflineCause: ' + computer.getOfflineCause());
     println('\tcomputer.offline: ' + computer.offline);
   } else {
     numberOfflineNodes ++
     println "  ERROR: can't get PATH from agent ${computer.name}."
     println('\tcomputer.isOffline: ' + computer.isOffline());
     println('\tcomputer.isTemporarilyOffline: ' + computer.isTemporarilyOffline());
     println('\tcomputer.getOfflineCause: ' + computer.getOfflineCause());
     println('\tcomputer.offline: ' + computer.offline);
     if (computer.isTemporarilyOffline()) {
       if (!computer.getOfflineCause().toString().contains("Disconnected by")) {
         computer.setTemporarilyOffline(false, agent.getComputer().getOfflineCause())
       }
     } else {
         computer.connect(true)
     }
   }
 }
println ("Number of Offline Nodes: " + numberOfflineNodes)
println ("Number of Nodes: " + numberNodes)