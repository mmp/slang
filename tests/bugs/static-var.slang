// gh-775-ext.slang
//TEST(compute):COMPARE_COMPUTE:

int test(int inVal)
{
    static int kVal = 16;
    return inVal + kVal;
}

//TEST_INPUT:ubuffer(data=[9 9 9 9], stride=4):dxbinding(0),glbinding(0),out
RWStructuredBuffer<int> outputBuffer : register(u0);

[numthreads(4, 1, 1)]
void computeMain(uint3 dispatchThreadID : SV_DispatchThreadID)
{
	uint tid = dispatchThreadID.x;

	int inVal = int(tid);
	int outVal = test(inVal);

	outputBuffer[tid] = outVal;
}