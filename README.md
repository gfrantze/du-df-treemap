About
=====

v1.01 (patch notes below)

This tool uses the Unix du/df tools to gather file system data and format it so that it can be displayed in a d3.js treemap. This is accomplished by generating json in a format similar to flare.json. Additionally, the Unix ls program is used to gather file data, which is then displayed when clicking the treemap.


Getting Started
===============

If you don't have node.js, download it: http://nodejs.org/download/

Clone this repo

cd du-df-treemap && npm install


Data Generation
===============

To use existing data **(only if you have access to my mongo instace!)**, skip this step. Otherwise, set your mongodb address, port, and db in connection.js:

module.exports = {

    db: new Db('mydbname', new Server('something.tgen.org', my_port),{safe:true})

};



To generate data*:
------------------


**nohup bash map_images.sh your_mongodb_address your_port your_desired_db &**

*this will take a while, generates data for /liang, /carpten, /ngd-data, /IVY and /su2c... make sure you have access to these directories!


OR:
---

To use directories **other than my presets**, you can append map_images.sh or generate data for a single image:

in map_images.sh, modify these lines:

images=( "/carpten" "/su2c" "/IVY" "/liang" "/ngd-data" "/trent" "/keats" "/MMRF" "/kjensen" "/AshionDrop")
collections=( "carpten" "su2c" "IVY" "liang" "ngddata" "trent" "keats" "MMRF" "kjensen" "AshionDrop"  )

Where images contains the image path, and collections contains the corresponding collection name for that path. 

Finally (could take hours, depending on image size):

bash map_images.sh your_mongodb_address your_port your_desired_db


Modifying the view
------------------

If you chose to create a directory that is not one of my map_images.sh presets, you must modify the view. Open views/tml.hjs and add a dropdown option. Make sure the value attribute is the name of your mongodb collection that contains the output of dlim_.py. 

```HTML
<select id="chn" name='image'>
                        <option value='liang'>/liang</option>
                        <option value='IVY'>/IVY</option>
                        <option value='su2c'>/su2c</option>
                        <option value='ngddata'>/ngd-data</option>
                        <option value='carpten'>/carpten</option>
                        <option value='whatever'>/whatever</option>
</select>
```


Starting the app
================

When data generation has finished, or if step was skipped, make sure in /du-df-treemap and:

**npm start**




v1.01 changes
-------------

- optimized file viewer load time
- HTML/CSS formatting changes

v1.02
------

- added default support for /trent, /keats and /MMRF

v1.1
------
- duplicate detection support script
- simplified data generation process
