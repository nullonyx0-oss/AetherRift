sampler uImage0 : register(s0);
float3 uColor;
float uOpacity;
float2 uTargetPosition;
float uTime;
float4 uSourceRect;
float2 uWorldPosition;
float uDirection;

float4 PixelShaderFunction(float4 sampleColor : COLOR0, float2 coords : TEXCOORD0) : COLOR0
{
    float4 color = tex2D(uImage0, coords);

    float wave = sin(coords.x * 10.0 + uTime * 8.0) * 0.02;
    float2 distortedCoords = coords + float2(0, wave);

    float4 distorted = tex2D(uImage0, distortedCoords);

    float edge = abs(coords.x - 0.5) * 2.0;
    float alpha = (1.0 - edge) * uOpacity;

    return distorted * float4(uColor, alpha);
}

technique Technique1
{
    pass SlashTrailPass
    {
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
};
