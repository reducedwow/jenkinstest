# jenkinstest


Kubernetes Kurulumu
    Ubuntu Server 22.04 üzerine kubernetes cluster 1 master 1 slave olarak kuruldu.
    
    Master ip (192.168.153.128)
    Slave  ip (192.168.153.129)
    
![cluster](https://user-images.githubusercontent.com/20577582/189660369-95c03e27-5a5f-406f-bf22-b1f58a8cb33f.png)


Yeni bir sunucu üzerine Jenkins kuruldu.

    Jenkins ip (192.168.153.130)
    

![credentials](https://user-images.githubusercontent.com/20577582/189663440-f735abdf-9d0a-44b1-88b1-c47524ac68e5.png)


Jenkins credentialslar oluşturuldu.

      pipeline {

        environment {
          dockerimagename = "beratpolat51/our-server"
          dockerImage = ""
        }

        agent any

        stages {

          stage('Checkout Source') {
            steps {
              git 'https://github.com/reducedwow/jenkinstest.git'
            }
          }

          stage('Prepare Image') {
            steps{
              script {
                //dockerImage = docker.build dockerimagename
                //docker.build("our-server", " -f /var/lib/jenkins/workspace/hostname/")
                sh "rm -r /home/jenkins/hostname/"
                sh 'cp -R /var/lib/jenkins/workspace/hostname /home/jenkins/'
                //sh 'cd /home/jenkins/hostname/'

              }
            }
          }

          stage('Build image') {
            steps{

              script {
                //dockerImage = docker.build dockerimagename
                //docker.build("our-server", " -f /var/lib/jenkins/workspace/hostname/")
                dir('/home/jenkins/hostname/') {
                    dockerImage = docker.build(dockerimagename, " .")
                  }

              }
            }
          }

          stage('Pushing Image') {
            steps{
              script {
                docker.withRegistry( 'https://registry.hub.docker.com', 'hubdocker' ) {
                  dockerImage.push()
                }
              }
            }
          }

          stage('Deploying App to Kubernetes') {
            steps {
              script {
                //kubernetesDeploy(configs: "deploymentservice.yml", kubeconfigId: "kubeberat")
                kubernetesDeploy(configs: "nodejsapp.yaml", kubeconfigId: "kubeberat")
              }
            }
          }
        }
      }
      
      
      
      
 ![jenkins_1](https://user-images.githubusercontent.com/20577582/189665388-2905ca28-eb7d-41fc-b4ea-f9ce064dc553.png)
 
 
 
    
      Skip to content
      [Jenkins]Jenkins
      ara (CTRL+K)
      1
      2
      berat polat

      çıkış
      Kontrol Merkezi
      hostname
      #63
      Status
      Changes
      Console Output
      View as plain text
      Edit Build Information
      Delete build ‘#63’
      Timings

      Git Build Data

      Restart from Stage
      Replay
      Pipeline Steps
      Workspaces
      Previous Build
      Konsol Çıktısı
      Started by user berat polat
      [Pipeline] Start of Pipeline
      [Pipeline] node
      Running on Jenkins in /var/lib/jenkins/workspace/hostname
      [Pipeline] {
      [Pipeline] withEnv
      [Pipeline] {
      [Pipeline] stage
      [Pipeline] { (Checkout Source)
      [Pipeline] git
      The recommended git tool is: NONE
      No credentials specified
       > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/hostname/.git # timeout=10
      Fetching changes from the remote Git repository
       > git config remote.origin.url https://github.com/reducedwow/jenkinstest.git # timeout=10
      Fetching upstream changes from https://github.com/reducedwow/jenkinstest.git
       > git --version # timeout=10
       > git --version # 'git version 2.34.1'
       > git fetch --tags --force --progress -- https://github.com/reducedwow/jenkinstest.git +refs/heads/*:refs/remotes/origin/* # timeout=10
       > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
      Checking out Revision 4cb2b6948fbf61385dd35a6c207db7080b6c8d88 (refs/remotes/origin/master)
       > git config core.sparsecheckout # timeout=10
       > git checkout -f 4cb2b6948fbf61385dd35a6c207db7080b6c8d88 # timeout=10
       > git branch -a -v --no-abbrev # timeout=10
       > git branch -D master # timeout=10
       > git checkout -b master 4cb2b6948fbf61385dd35a6c207db7080b6c8d88 # timeout=10
      Commit message: "Update Dockerfile"
       > git rev-list --no-walk 8ad91cab86460eedec723eb4fe20f83915cb1e4a # timeout=10
      [Pipeline] }
      [Pipeline] // stage
      [Pipeline] stage
      [Pipeline] { (Prepare Image)
      [Pipeline] script
      [Pipeline] {
      [Pipeline] sh
      + rm -r /home/jenkins/hostname/
      [Pipeline] sh
      + cp -R /var/lib/jenkins/workspace/hostname /home/jenkins/
      [Pipeline] }
      [Pipeline] // script
      [Pipeline] }
      [Pipeline] // stage
      [Pipeline] stage
      [Pipeline] { (Build image)
      [Pipeline] script
      [Pipeline] {
      [Pipeline] dir
      Running in /home/jenkins/hostname
      [Pipeline] {
      [Pipeline] isUnix
      [Pipeline] withEnv
      [Pipeline] {
      [Pipeline] sh
      + docker build -t beratpolat51/our-server .
      Sending build context to Docker daemon  196.6kB

      Step 1/8 : FROM node:14
       ---> 41706aa77d80
      Step 2/8 : WORKDIR /usr/src/app
       ---> Using cache
       ---> 3207b2f04939
      Step 3/8 : COPY package*.json ./
       ---> Using cache
       ---> 8b6dd9d4991f
      Step 4/8 : RUN npm install
       ---> Using cache
       ---> 6d089787ce3a
      Step 5/8 : RUN npm install express
       ---> Using cache
       ---> 4c11beaa27ec
      Step 6/8 : COPY . .
       ---> c00388a2ec5d
      Step 7/8 : EXPOSE 3000
       ---> Running in 90d667187c81
      Removing intermediate container 90d667187c81
       ---> 7304f1dcbe77
      Step 8/8 : CMD [ "node", "index.js" ]
       ---> Running in 167e1661623d
      Removing intermediate container 167e1661623d
       ---> d4f3f87a93e9
      Successfully built d4f3f87a93e9
      Successfully tagged beratpolat51/our-server:latest
      [Pipeline] }
      [Pipeline] // withEnv
      [Pipeline] }
      [Pipeline] // dir
      [Pipeline] }
      [Pipeline] // script
      [Pipeline] }
      [Pipeline] // stage
      [Pipeline] stage
      [Pipeline] { (Pushing Image)
      [Pipeline] script
      [Pipeline] {
      [Pipeline] withEnv
      [Pipeline] {
      [Pipeline] withDockerRegistry
      $ docker login -u beratpolat51 -p ******** https://registry.hub.docker.com
      WARNING! Using --password via the CLI is insecure. Use --password-stdin.
      WARNING! Your password will be stored unencrypted in /var/lib/jenkins/workspace/hostname@tmp/78a1580e-04d4-4c89-a0b9-937bf7336eb3/config.json.
      Configure a credential helper to remove this warning. See
      https://docs.docker.com/engine/reference/commandline/login/#credentials-store

      Login Succeeded
      [Pipeline] {
      [Pipeline] isUnix
      [Pipeline] withEnv
      [Pipeline] {
      [Pipeline] sh
      + docker tag beratpolat51/our-server registry.hub.docker.com/beratpolat51/our-server:latest
      [Pipeline] }
      [Pipeline] // withEnv
      [Pipeline] isUnix
      [Pipeline] withEnv
      [Pipeline] {
      [Pipeline] sh
      + docker push registry.hub.docker.com/beratpolat51/our-server:latest
      The push refers to repository [registry.hub.docker.com/beratpolat51/our-server]
      fab088644ad0: Preparing
      320dec6adfb9: Preparing
      71d6afc2dbd9: Preparing
      dab0e5fd6305: Preparing
      8344d6787f62: Preparing
      b4a4fabd260f: Preparing
      a43c0abca457: Preparing
      4d16f311fb8f: Preparing
      a51886a09280: Preparing
      1e69483976e4: Preparing
      47b6660a2b9b: Preparing
      5cbe2d191b8f: Preparing
      07b905e91599: Preparing
      20833a96725e: Preparing
      b4a4fabd260f: Waiting
      a43c0abca457: Waiting
      4d16f311fb8f: Waiting
      a51886a09280: Waiting
      1e69483976e4: Waiting
      47b6660a2b9b: Waiting
      5cbe2d191b8f: Waiting
      07b905e91599: Waiting
      20833a96725e: Waiting
      8344d6787f62: Layer already exists
      320dec6adfb9: Layer already exists
      71d6afc2dbd9: Layer already exists
      dab0e5fd6305: Layer already exists
      b4a4fabd260f: Layer already exists
      4d16f311fb8f: Layer already exists
      a51886a09280: Layer already exists
      a43c0abca457: Layer already exists
      5cbe2d191b8f: Layer already exists
      1e69483976e4: Layer already exists
      47b6660a2b9b: Layer already exists
      07b905e91599: Layer already exists
      20833a96725e: Layer already exists
      fab088644ad0: Pushed
      latest: digest: sha256:da7eed11d1e011f685a9d5d3404f3032af641e7b7198ba884b9d0d195cdb9fe1 size: 3257
      [Pipeline] }
      [Pipeline] // withEnv
      [Pipeline] }
      [Pipeline] // withDockerRegistry
      [Pipeline] }
      [Pipeline] // withEnv
      [Pipeline] }
      [Pipeline] // script
      [Pipeline] }
      [Pipeline] // stage
      [Pipeline] stage
      [Pipeline] { (Deploying App to Kubernetes)
      [Pipeline] script
      [Pipeline] {
      [Pipeline] kubernetesDeploy
      Starting Kubernetes deployment
      Loading configuration: /var/lib/jenkins/workspace/hostname/nodejsapp.yaml
      Applied Deployment: Deployment(apiVersion=apps/v1, kind=Deployment, metadata=ObjectMeta(annotations=null, clusterName=null, creationTimestamp=2022-09-12T05:56:33Z, deletionGracePeriodSeconds=null, deletionTimestamp=null, finalizers=[], generateName=null, generation=8, initializers=null, labels={app=nodejs-app}, name=nodejs-app, namespace=default, ownerReferences=[], resourceVersion=174998, selfLink=null, uid=4a158489-3ea0-421a-879c-a3d8efcabc3f, additionalProperties={managedFields=[{manager=kube-controller-manager, operation=Update, apiVersion=apps/v1, time=2022-09-12T08:00:45Z, fieldsType=FieldsV1, fieldsV1={f:status={f:conditions={.={}, k:{"type":"Available"}={.={}, f:lastTransitionTime={}, f:lastUpdateTime={}, f:message={}, f:reason={}, f:status={}, f:type={}}, k:{"type":"Progressing"}={.={}, f:lastTransitionTime={}, f:lastUpdateTime={}, f:message={}, f:reason={}, f:status={}, f:type={}}}, f:observedGeneration={}}}, subresource=status}, {manager=okhttp, operation=Update, apiVersion=apps/v1, time=2022-09-12T08:01:11Z, fieldsType=FieldsV1, fieldsV1={f:metadata={f:labels={.={}, f:app={}}}, f:spec={f:progressDeadlineSeconds={}, f:replicas={}, f:revisionHistoryLimit={}, f:selector={}, f:strategy={f:rollingUpdate={.={}, f:maxSurge={}, f:maxUnavailable={}}, f:type={}}, f:template={f:metadata={f:labels={.={}, f:app={}}}, f:spec={f:containers={k:{"name":"nodejs-app"}={.={}, f:image={}, f:imagePullPolicy={}, f:name={}, f:ports={.={}, k:{"containerPort":3000,"protocol":"TCP"}={.={}, f:containerPort={}, f:protocol={}}}, f:resources={}, f:terminationMessagePath={}, f:terminationMessagePolicy={}}}, f:dnsPolicy={}, f:restartPolicy={}, f:schedulerName={}, f:securityContext={}, f:terminationGracePeriodSeconds={}}}}}}]}), spec=DeploymentSpec(minReadySeconds=null, paused=null, progressDeadlineSeconds=600, replicas=1, revisionHistoryLimit=10, selector=LabelSelector(matchExpressions=[], matchLabels={app=nodejs-app}, additionalProperties={}), strategy=DeploymentStrategy(rollingUpdate=RollingUpdateDeployment(maxSurge=IntOrString(IntVal=null, Kind=null, StrVal=25%, additionalProperties={}), maxUnavailable=IntOrString(IntVal=null, Kind=null, StrVal=25%, additionalProperties={}), additionalProperties={}), type=RollingUpdate, additionalProperties={}), template=PodTemplateSpec(metadata=ObjectMeta(annotations=null, clusterName=null, creationTimestamp=null, deletionGracePeriodSeconds=null, deletionTimestamp=null, finalizers=[], generateName=null, generation=null, initializers=null, labels={app=nodejs-app}, name=null, namespace=null, ownerReferences=[], resourceVersion=null, selfLink=null, uid=null, additionalProperties={}), spec=PodSpec(activeDeadlineSeconds=null, affinity=null, automountServiceAccountToken=null, containers=[Container(args=[], command=[], env=[], envFrom=[], image=beratpolat51/our-server:latest, imagePullPolicy=Always, lifecycle=null, livenessProbe=null, name=nodejs-app, ports=[ContainerPort(containerPort=3000, hostIP=null, hostPort=null, name=null, protocol=TCP, additionalProperties={})], readinessProbe=null, resources=ResourceRequirements(limits=null, requests=null, additionalProperties={}), securityContext=null, stdin=null, stdinOnce=null, terminationMessagePath=/dev/termination-log, terminationMessagePolicy=File, tty=null, volumeDevices=[], volumeMounts=[], workingDir=null, additionalProperties={})], dnsConfig=null, dnsPolicy=ClusterFirst, hostAliases=[], hostIPC=null, hostNetwork=null, hostPID=null, hostname=null, imagePullSecrets=[], initContainers=[], nodeName=null, nodeSelector=null, priority=null, priorityClassName=null, restartPolicy=Always, schedulerName=default-scheduler, securityContext=PodSecurityContext(fsGroup=null, runAsNonRoot=null, runAsUser=null, seLinuxOptions=null, supplementalGroups=[], additionalProperties={}), serviceAccount=null, serviceAccountName=null, subdomain=null, terminationGracePeriodSeconds=30, tolerations=[], volumes=[], additionalProperties={}), additionalProperties={}), additionalProperties={}), status=DeploymentStatus(availableReplicas=null, collisionCount=null, conditions=[DeploymentCondition(lastTransitionTime=2022-09-12T05:56:33Z, lastUpdateTime=2022-09-12T07:34:17Z, message=ReplicaSet "nodejs-app-5767b66f5f" has successfully progressed., reason=NewReplicaSetAvailable, status=True, type=Progressing, additionalProperties={}), DeploymentCondition(lastTransitionTime=2022-09-12T08:00:45Z, lastUpdateTime=2022-09-12T08:00:45Z, message=Deployment has minimum availability., reason=MinimumReplicasAvailable, status=True, type=Available, additionalProperties={})], observedGeneration=7, readyReplicas=null, replicas=null, unavailableReplicas=null, updatedReplicas=null, additionalProperties={}), additionalProperties={})
      Created Service: Service(apiVersion=v1, kind=Service, metadata=ObjectMeta(annotations=null, clusterName=null, creationTimestamp=2022-09-12T08:01:11Z, deletionGracePeriodSeconds=null, deletionTimestamp=null, finalizers=[], generateName=null, generation=null, initializers=null, labels=null, name=nodejs-app, namespace=default, ownerReferences=[], resourceVersion=175005, selfLink=null, uid=b4ff3467-3e50-4e38-9f9f-8fd15d4d7b27, additionalProperties={managedFields=[{manager=okhttp, operation=Update, apiVersion=v1, time=2022-09-12T08:01:11Z, fieldsType=FieldsV1, fieldsV1={f:spec={f:allocateLoadBalancerNodePorts={}, f:externalTrafficPolicy={}, f:internalTrafficPolicy={}, f:ports={.={}, k:{"port":80,"protocol":"TCP"}={.={}, f:name={}, f:port={}, f:protocol={}, f:targetPort={}}}, f:selector={}, f:sessionAffinity={}, f:type={}}}}]}), spec=ServiceSpec(clusterIP=10.109.101.211, externalIPs=[], externalName=null, externalTrafficPolicy=Cluster, healthCheckNodePort=null, loadBalancerIP=null, loadBalancerSourceRanges=[], ports=[ServicePort(name=http, nodePort=30359, port=80, protocol=TCP, targetPort=IntOrString(IntVal=3000, Kind=null, StrVal=null, additionalProperties={}), additionalProperties={})], publishNotReadyAddresses=null, selector={app=nodejs-app}, sessionAffinity=None, sessionAffinityConfig=null, type=LoadBalancer, additionalProperties={clusterIPs=[10.109.101.211], ipFamilies=[IPv4], ipFamilyPolicy=SingleStack, allocateLoadBalancerNodePorts=true, internalTrafficPolicy=Cluster}), status=ServiceStatus(loadBalancer=LoadBalancerStatus(ingress=[], additionalProperties={}), additionalProperties={}), additionalProperties={})
      Finished Kubernetes deployment
      [Pipeline] }
      [Pipeline] // script
      [Pipeline] }
      [Pipeline] // stage
      [Pipeline] }
      [Pipeline] // withEnv
      [Pipeline] }
      [Pipeline] // node
      [Pipeline] End of Pipeline
      Finished: SUCCESS
      REST API
      Jenkins 2.361.1





![server_1](https://user-images.githubusercontent.com/20577582/189666229-b2a039c3-db58-471b-9468-e046dcbfd492.png)

 
