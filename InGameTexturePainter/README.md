# Godot 4.6 Runtime Texture Splat Map Painting

This is a port of the original Godot 3.x project to Godot 4.6.

## Features
- Runtime texture painting using splat maps
- World position to UV coordinate mapping
- Barycentric coordinate calculation for precise UV lookup
- Dynamic viewport render target for paint strokes

## How It Works

1. **VertexPositionMapper.gd** - Maps world Vector3 positions to mesh UV coordinates using:
   - MeshDataTool to load mesh vertices and normals
   - Barycentric coordinates to find UV from a world position
   - Caches vertex data for runtime performance

2. **TexturePainter.gd** - Main painting controller:
   - Casts rays from camera to detect mesh hits
   - Converts hit positions to UV coordinates
   - Moves brush sprite in the viewport to paint

3. **DrawViewport.gd** - Manages the render target:
   - SubViewport that accumulates paint strokes
   - Brush sprite that moves to paint locations

4. **BlendDamageMask.gdshader** - Blends textures:
   - Mixes dirt/damage texture with base texture
   - Uses splat map (viewport texture) as blend mask

## Controls
- **WASD** - Move
- **Mouse** - Look around
- **Left Click + Drag** - Paint on the mesh
- **Space** - Jump

## Godot 4.x Changes from 3.x

Key API changes made during the port:
- `Spatial` → `Node3D`
- `KinematicBody` → `CharacterBody3D`
- `MeshInstance` → `MeshInstance3D`
- `Viewport` → `SubViewport`
- `Sprite` → `Sprite2D`
- `onready` → `@onready`
- `export` → `@export`
- `PoolVector3Array` → `PackedVector3Array`
- `deg2rad()` → `deg_to_rad()`
- `xform()` → `*` operator (Transform3D multiplication)
- `set_shader_param()` → `set_shader_parameter()`
- `get_surface_material()` → `get_surface_override_material()`
- Raycast API now uses `PhysicsRayQueryParameters3D`
- `yield()` → `await`

## Credits
Original project by Alfred Baudisch:
https://alfredbaudisch.com/godot-engine/godot-engine-in-game-splat-map-texture-painting-dirt-removal-effect/
