@tool
extends Node



func _ready():
  var image = load("res://assets/textures/samples/s_CloudTexture.png").get_image()
  
  #image.lock()

  var width = image.get_width()
  var height = image.get_height()
  
  var vertices = PackedVector3Array()
  var indices = PackedInt32Array()
  var uvs = PackedVector2Array()
  var threshold = 1.0
  var vertex_map = {}
  
  for y in range(height):
      for x in range(width):
          var color = image.get_pixel(x, y)
          if color.a > threshold:
              var idx = vertices.size()
              vertex_map[Vector2i(x, y)] = idx
              vertices.append(Vector3(x, 0.0, y))  # 2D mesh on X-Z plane
              uvs.append(Vector2(float(x) / width, float(y) / height))
  
  for y in range(height - 1):
      for x in range(width - 1):
          var a = Vector2i(x, y)
          var b = Vector2i(x + 1, y)
          var c = Vector2i(x, y + 1)
          var d = Vector2i(x + 1, y + 1)
  
          if vertex_map.has(a) and vertex_map.has(b) and vertex_map.has(c):
              indices.append(vertex_map[a])
              indices.append(vertex_map[b])
              indices.append(vertex_map[c])
  
          if vertex_map.has(b) and vertex_map.has(d) and vertex_map.has(c):
              indices.append(vertex_map[b])
              indices.append(vertex_map[d])
              indices.append(vertex_map[c])
  
  var arrays = []
  arrays.resize(Mesh.ARRAY_MAX)
  arrays[Mesh.ARRAY_VERTEX] = vertices
  arrays[Mesh.ARRAY_TEX_UV] = uvs
  arrays[Mesh.ARRAY_INDEX] = indices
  var am  = ArrayMesh.new()
  am.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
  
  var m = MeshInstance3D.new()
  m.mesh = am
  add_child(m)
