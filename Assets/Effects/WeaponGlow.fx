sampler uImage0 : register(s0);
sampler uImage1 : register(s1);
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

    float pulse = sin(uTime * 3.0) * 0.5 + 0.5;

    float2 offset = float2(sin(uTime * 5.0) * 0.002, cos(uTime * 4.5) * 0.002);
    float4 glowColor = tex2D(uImage0, coords + offset);

    color.rgb = lerp(color.rgb, uColor, pulse * 0.4);
    color.rgb += glowColor.rgb * pulse * 0.3;

    return color * sampleColor;
}

technique Technique1
{
    pass WeaponGlowPass
    {
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
};
