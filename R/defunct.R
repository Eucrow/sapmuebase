# this is a function generator (clusure): a function which returns another function
# to use in deprecated functions
# copy from: http://emilkirkegaard.dk/en/?p=6395
defunct = function(msg = "This function is depreciated") function(...) return(stop(msg))
