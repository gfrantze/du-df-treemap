var db = require('../connection').db;


db.open(function(err,db1){


    var test= db1.collection(process.argv[2]+"_lRp");


	test.aggregate([

                     {$group: { 
					    _id:  "$size" , 
					    paths: { $addToSet: "$path" },
					    count: { $sum: 1 } 
					 }},
                    
                     {$match: { 
					    count: { $gt: 1 } 
					 }},

					 {$sort: {
                        "_id" : 1
                     }},

                     {$match: { 
    					count: { $gt: 1 } 
  					 }}

            ],{allowDiskUse:true}).each(function(err, docs) {


            	if(docs){
            		
            		var up = docs.paths;
              		if(up){
						test.update({"size":docs._id},{$set:{"aalt":up} },{multi:true} );
					}
					
					
				}

				else{
					db.close();
				}

            	
                    
            });







})
