
/**
 * Allows for the construction of linear timed events, with one-time firing
 * @param {array} timeCodes An array of times in milliseconds which upon reaching will trigger an event
 */
function timerSequence(timeCodes) constructor{
	timeCodeQueue = array_reverse(timeCodes)
	originalLength = array_length(timeCodeQueue)
	
	/**
	 * Checks the current elapsed time and returns the index of any timers that have been triggered.
	 * @param {any} currentTime The current time in the sequence.
	 * @returns {real} The index of the timer tirggered.
	 */
	static sampleSequence = function(currentTime){
		var currentTimer = array_last(timeCodeQueue)
		if currentTime > currentTimer{
			array_pop(timeCodeQueue)
			return originalLength - array_length(timeCodeQueue) - 1
		}
		else
			return -1
	}
}