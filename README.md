Getting Started
===============

If you don't have node.js, download it: http://nodejs.org/download/

Clone this repo

cd du-df-treemap && npm install


Data Generation
===============

To use existing data, skip this step. Otherwise, set your mongodb address, port, and db in connection.js:

module.exports = {

    db: new Db('mydbname', new Server('something.tgen.org', my_port),{safe:true})

};



To generate data*:
------------------


**nohup bash map_images.sh your_mongodb_address your_port your_desired_db &**

*this will take a while, generates data for /liang, /carpten, /ngd-data, /IVY and /su2c... make sure you have access to these directories!


OR:
---

To use other directories **other than my presets**, you can append map_images.sh or generate data for a single image:

First, get disk usage statistics. -S flag is required!

**du -S /some_image --exclude=/some_image/.snapshot 2>/dev/null > some_image.txt**

Next, get empty space...

**df /some_image > df_some_image.txt**

Next, get file information...

**ls -laRp /some_image  > ls_lRp_some_image.txt**

This script will create a single nested JSON document in a format similar to flare.json. Parameters: your du text file output, your df text file output, your desired mongodb collection name, your mongodb ip, your mongodb port, and the name of your database.

**python dlim_.py some_image.txt df_some_image.txt collection_name mongodb_ip mongodb_port mongodb_dbname**

This script will generate mongodb documents that represent ls -laRp data. Paramaters: your ls text fileput, your desired mongodb collection name, your mongodb ip, your mongodb port, and the name of your database.

**python parse_lRp.py ls_lRp_some_image.txt collection_name mongodb_ip mongodb_port mongodb_dbname**



Starting the app
================

When data generation has finished, or if step was skipped, make sure in /du-df-treemap and:

**npm start**
