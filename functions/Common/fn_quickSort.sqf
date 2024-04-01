// !!!
// _code params [_a, _b]
//  must return TRUE if a < b

params ["_arr", "_low", "_high", "_codeParams", "_code"];

// A utility function to swap two elements
private _fnc_swap =
{
	params ["_arr", "_i", "_j"];
	private _temp = _arr#_i;
    _arr set [_i, (_arr#_j)];
    _arr set [_j, _temp];
};

 
// This function takes last element as pivot,
// places the pivot element at its correct position
// in sorted array, and places all smaller to left
// of pivot and all greater elements to right of pivot
private _fnc_partition =
{
	params ["_arr", "_low", "_high"];
	
	// Choosing the pivot
	private _pivot = _arr#_high;

	// Index of smaller element and indicates
	// the right position of pivot found so far
	private _i = (_low - 1);
	for [{_j = _low}, {_j <= _high - 1}, {_j=_j+1}] do
	{
		// If current element is smaller than the pivot
		// if ((_arr#_j) < _pivot) then
		if ([(_arr#_j), _pivot] call _code) then
		{
			// Increment index of smaller element
			_i = _i + 1;
			[_arr, _i, _j] call _fnc_swap;
		};
	};
	[_arr, _i + 1, _high] call _fnc_swap;
	
	(_i + 1)
};
 
// The main function that implements QuickSort
// arr[] --> Array to be sorted,
// low --> Starting index,
// high --> Ending index
//static void quickSort(int[] arr, int low, int high)

if (_low < _high) then 
{
	// pi is partitioning index, arr[p]
	// is now at right place
	//private _pi = _this call _fnc_partition;
	
	// Choosing the pivot
	private _pivot = _arr#_high;

	// Index of smaller element and indicates
	// the right position of pivot found so far
	private _i = (_low - 1);
	for [{_j = _low}, {_j <= _high - 1}, {_j=_j+1}] do
	{
		// If current element is smaller than the pivot
		// if ((_arr#_j) < _pivot) then
		if ([(_arr#_j), _pivot, _codeParams] call _code) then
		{
			// Increment index of smaller element
			_i = _i + 1;
			[_arr, _i, _j] call _fnc_swap;
		};
	};
	[_arr, _i + 1, _high] call _fnc_swap;
	_i = _i + 1;
	
	// Separately sort elements before
	// and after partition index
	[_arr, _low, _i - 1, _codeParams, _code] call AZ_fnc_quickSort;
	[_arr, _i + 1, _high, _codeParams, _code] call AZ_fnc_quickSort;
	
};
/*
private static void doSort(int start, int end) 
{
	if (start >= end)
		return;
	int i = start, j = end;
	int cur = i - (i - j) / 2;
	while (i < j) 
	{
		while (i < cur && (array[i] <= array[cur])) 
		{
			i++;
		}
		while (j > cur && (array[cur] <= array[j])) 
		{
			j--;
		}
		if (i < j) 
		{
			int temp = array[i];
			array[i] = array[j];
			array[j] = temp;
			if (i == cur)
				cur = j;
			else if (j == cur)
				cur = i;
		}
	}
	doSort(start, cur);
	doSort(cur+1, end);
}
*/