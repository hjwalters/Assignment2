## This function creates a special "matrix" object that can cache its inverse.
## It's used by cacheSolve to get, set the inverted matrix.
## It uses <<- assignment operator to assign a value to an object
## so they are not exposed to the outside environment.
## It returns a list containing functions to set the matrix,
## get the matrix, set the inverse, get the inverse



makeCacheMatrix <- function(x = matrix()) {

	inv <- NULL
	set <- function(y) {
	    x <<- y
	    inv <<- NULL
	}

	get <- function() x
	setinv <- function(inverse) inv <<- inverse
	getinv <- function() inv
	list(set=set, get=get, setinv=setinv, getinv=getinv)

}


## Returns a matrix that is the inverse of x from makeCacheMatrix
## If the inverse has been calculated, it gets from cache and skips
## calculation. Else, it will calculate the inverse.

cacheSolve <- function(x, ...) {

	inv <- x$getinv()

	if (!is.null(inv)) {
		message("getting cached data")
		return(inv)
	}

	data <- x$get()
	inv <- solve(data, ...)
	x$setinv(inv)
	return(inv)

}
