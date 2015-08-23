<<<<<<< HEAD
# Matrix inversion is usually a costly computation and there may be some benefit

# to caching the inverse of a matrix rather than compute it repeatedly. The

# following two functions are used to cache the inverse of a matrix.

# makeCacheMatrix creates a list containing a function to

# 1. set the value of the matrix

# 2. get the value of the matrix

# 3. set the value of inverse of the matrix

# 4. get the value of inverse of the matrix

# makeCacheMatrix takes a Matrix, saved in the private variable x

	makeCacheMatrix <- function(x = matrix()) {

# initialize the inverse of matrix to NULL during the first call to makeCacheMatrix
# this is needed because getinverse() is called immediately after
# the makeCacheMatrix function is constructed, without a call to setinverse. We know we must first calculate the inverse in cachesolve. 

	inv <- NULL
	
# function to set a new value for the underlying matrix
# this invalidates the cached inverse, inv
# we use the <<- operator to set the value of x and inv because we want to modify x and inv defined in the enclosing environment (created 
# when makeCacheMatrix was first called), not in the environment local to set(),in which x and inv are undefined.
# we must reset inv to NULL since we are modifying the underlying
# Matrix and the cached value is no longer the valid
    
	set <- function(y) {
                x <<- y
                inv <<- NULL
        }

# getter function for underlying matrix

    get <- function() {x}

# set the inverse of the matrix x.  Called by cachesolve,
# Again we use the <<- operator because we want to modify the inv defined in the enclosing function makeCacheMatrix, not the inv local to setinverse,which would be undefined.
        
    setinverse <- function(inverse) {inv <<- inverse}

# returns the inverse.  Will be null if setinverse has not been called or if set is called after the last call to setinverse
        
    getinverse <- function() {inv}
    
# return value of the makeCacheMatrix function is a list

    list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
		}

# The following function returns the inverse of the matrix. It first checks if the inverse has already been computed. If so, it gets the result and skips the computation. If not, it computes the inverse, sets the value in the cache via setinverse function.
# This function assumes that the matrix is always invertible.

	cacheSolve <- function(x, ...) {

# get the inverse of the matrix defined inside x.	
	
## Return a matrix that is the inverse of 'x'

	inv <- x$getinverse()

# if we've already computed the inverse and stored it via setinverse(),and have not invalidated the cache by calling set(), return the cached version of x

    if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        
# call get() to get the underlying matrix

    data <- x$get()

# calculate the inverse of the underlying matrix

    inv <- solve(data, ...)
 
# now set the inverse in x so we cache it and dont need to needlessly
    
    x$setinverse(inv)

# return the caching matrix

    inv
}

