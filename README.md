About
=====

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

First, get disk usage statistics. -S flag is required!

**du -S /some_image --exclude=/some_image/.snapshot 2>/dev/null > some_image.txt**

Next, get empty space...

**df /some_image > df_some_image.txt**

Next, get file information...

**ls -laRp /some_image  > ls_lRp_some_image.txt**

This next script will create a single nested JSON document in a format similar to flare.json. Parameters: your du text file output, your df text file output, your desired mongodb collection name, your mongodb ip, your mongodb port, and the name of your database.

**python dlim_.py some_image.txt df_some_image.txt collection_name mongodb_ip mongodb_port mongodb_dbname**

This final script will generate mongodb documents that represent ls -laRp data. Parameters: your ls text fileput, your desired mongodb collection name, your mongodb ip, your mongodb port, and the name of your database. **your collection name must contain the suffix _lRp for this step**

**python parse_lRp.py ls_lRp_some_image.txt collection_name_lRp mongodb_ip mongodb_port mongodb_dbname**

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
