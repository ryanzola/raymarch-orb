uniform vec4 iResolution;

varying vec2 vUv;

float sphere(vec3 p) {
  return length(p) - 0.5;
}

float scene(vec3 p) {
  return sphere(p);
}

vec3 getNormal(vec3 p) {
  vec2 o = vec2(0.001, 0.0);

  return normalize(
    vec3(
      scene(p + o.xyy),
      scene(p + o.yxy),
      scene(p + o.yyx)
    )
  );
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = (vUv - vec2(0.5)) * iResolution.zw + vec2(0.5);
  vec2 p = uv - vec2(0.5);

  float bw = step(uv.x, 0.5);

  vec3 color = vec3(0.0);

  vec3 camPos = vec3(0.0, 0.0, 2.0);
  vec3 ray = normalize(vec3(p, -1.0));

  vec3 rayPos = camPos;
  float currDist = 0.0;
  float rayLen = 0.0;

  vec3 light = vec3(-1.0, 1.0, 1.0);

  for(int i = 0; i <= 64; i++) {
    currDist = scene(rayPos);
    rayLen += currDist;

    rayPos = camPos + ray * rayLen;

    if(abs(currDist) < 0.0001) {
      vec3 n = getNormal(rayPos);

      float diff = dot(n, light);

      color = vec3(diff, 0.0, 0.0);
    }
  }

  fragColor = vec4(color, 1.0);
}

void main() {
  mainImage(gl_FragColor, gl_FragCoord.xy);
}
