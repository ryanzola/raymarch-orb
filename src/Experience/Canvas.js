import * as THREE from 'three'

import Experience from './Experience'

import vertex from './shaders/canvas/vertex.glsl'
import fragment from './shaders/canvas/fragment.glsl'

export default class Canvas
{
    constructor(_options)
    {
        this.experience = new Experience()
        this.scene = this.experience.scene
        this.config = this.experience.config

        this.width = this.config.width
        this.height = this.config.height

        this.setGeometry()
        this.setMaterial()
        this.setMesh()
        this.resize()
    }

    resize() {
      this.width = this.config.width
      this.height = this.config.height
      this.imageAspect = 1;

      let a1, a2
      if(this.height / this.width > this.imageAspect) {
        a1 = (this.width / this.height) * this.imageAspect
        a2 = 1
      } else {
        a1 = 1
        a2 = (this.height / this.width) / this.imageAspect
      }

      this.material.uniforms.iResolution.value = new THREE.Vector4(this.width, this.height, a1, a2)
    }

    setGeometry() {
      this.geometry = new THREE.PlaneBufferGeometry(2, 2, 1, 1)
    }

    setMaterial() {
      this.material = new THREE.ShaderMaterial({
        vertexShader: vertex,
        fragmentShader: fragment,
        uniforms: {
          iResolution: { value: new THREE.Vector3(this.config.width, this.config.height, 1) }
        }
      })
    }

    setMesh() {
      this.mesh = new THREE.Mesh(this.geometry, this.material)
      this.scene.add(this.mesh)
    }

    update() {}
}