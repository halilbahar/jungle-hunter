# Jungle-Hunter

#### Halil Bahar, Sonja Cao, Christian Donnabauer, Simon Zweimüller

### Problem:

Currently the Jungles and Forests in Europe are beeing harmed, just to use the wood for economics. 

### Functionality:

As a user of the app I want to:

+ view tracks on a map
+ view the controlpoints of a track 
+ take and save photos, if I am at a specific Controlpoint
+ export the images as a photobook
+ get achievements if I cleared a track
+ search for specific tracks

### Aim:

The aim of this project is to motivate people to go out and explore those jungles to save them at the same time.

### [YouTrack](https://vm81.htl-leonding.ac.at/agiles/99-198/100-779)


### Installation:

Currently you need to setup a "fake" HTTP Response for the App, to display controlpoints:

1. Open [Mocky](https://www.mocky.io). Then copy & paste the content of the **data.json** file, which is found in the root directory of the repo, into the body part of the form. 
2. Then click onto the Generate HTTP Response button
3. Copy the url and paste it into the **MapViewController.swift** file instead of the old mocky link
4. If the link is not **https** by default, just add a "s" after "http" in the MapViewController.swift 