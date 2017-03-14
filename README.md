# moses

The Military Open Simulator Enterprise Strategy (moses) is a method and strategy for deploying a set of OpenSimulator services and simulators in order to run a private grid.  This grid, once built, can reside in an enclave, offline, or be hosted online with a single entry point.

This composition can be run on a docker host, and any region simulators run on additional machines.  The necessary ports for region connectivity are exposed in this composition, but region traffic is not proxied.  The region UDP and TCP ports must be handled outside of docker.

# features

This deployment strategy is a docker composition, allowing for a quick set-up and use of an otherwise difficult to configure system.  The system is being separated into replaceable microservices where possible, and sane defaults have been selected where possible.

## Halcyon

This simulator system is based on the Halcyon fork of OpenSimulator.  The performance/feature trade-off between this fork and upstream OpenSimulator was a simple decision for what the MOSES team needs.  Halcyon runs multiple services in order to be a performant grid, they include:  GridServer.exe, UserServer.exe, MessagingServer.exe, Aperture, Whip, and MySQL.  These are each spun up as a separate container.  In the future we hope to extend this to allow for grid-service clustering and scaling, but it is currently single-instance only.

The Halcyon.exe simulator processes are currently windows-only.  It would be much easier to include the simulators and simplify the networking model drastically, but they must be run on windows machines.

## Grid Management

This strategy includes the MOSES Grid Manager (MGM).  This web application includes an html5 single-page application for grid and user management, and several scripts for user templating, etc.  This application, in concert with mgmNode when deployed, configured ans migrates regions, performs performance monitoring, aggregates and serves region logs, and allows administrative actions from within the web application.

## Freeswitch

This strategy includes both a freeswitch server for voice connectivity, but a management service allowing halcyon voice chat over freeswitch using unmodified OpenSimulator capable clients.

## Offline Messaging

This strategy includes a serviec for storing offline messages for the Halcyon grid.

## Map Service

Coming soon... an improved map service using Anaximander2.

# Build and Deploy

As this composition is composed of so many different pieces, we selected docker also as the build environment.  Contained in these files are scripts that create docker containers to hold the development requirements for the services, as well as slimmed produciton containers for deployment.  While each of these services can be developed and run natively, network and requirements management would be a steep requirement.

More details will be added here as this develops, work is ongoing for both the microservice conversion, and for getting optimal behavior from the services for a small-grid deployment.
