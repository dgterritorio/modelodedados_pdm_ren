<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:se="http://www.opengis.net/se" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:ogc="http://www.opengis.net/ogc">
  <NamedLayer>
    <se:Name>objeto_ponto_o</se:Name>
    <UserStyle>
      <se:Name>objeto_ponto_o</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>23 - Equipamento de Utilização Coletiva</se:Name>
          <se:Description>
            <se:Title>23 - Equipamento de Utilização Coletiva</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>23</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#a0a0a0</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">1.53846</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:OnlineResource xlink:type="simple" xlink:href="ttf://Arial"/>
                <se:Format>ttf</se:Format>
                <se:MarkIndex>69</se:MarkIndex>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>24 - Equipamento de Utilização Coletiva Previsto</se:Name>
          <se:Description>
            <se:Title>24 - Equipamento de Utilização Coletiva Previsto</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>24</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">1.53846</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:OnlineResource xlink:type="simple" xlink:href="ttf://Arial"/>
                <se:Format>ttf</se:Format>
                <se:MarkIndex>69</se:MarkIndex>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>31 - Nó Rodoviário</se:Name>
          <se:Description>
            <se:Title>31 - Nó Rodoviário</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>31</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ff0000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>18</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>32 - Nó Rodoviário Previsto</se:Name>
          <se:Description>
            <se:Title>32 - Nó Rodoviário Previsto</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>32</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ff0000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>18</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>semi_circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>18</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>33 - Estação ou Interface de Transporte</se:Name>
          <se:Description>
            <se:Title>33 - Estação ou Interface de Transporte</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>33</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>34 - Estação ou Interface de Transporte Prevista</se:Name>
          <se:Description>
            <se:Title>34 - Estação ou Interface de Transporte Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>34</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>37 - Infraestrutura de Transporte Aéreo</se:Name>
          <se:Description>
            <se:Title>37 - Infraestrutura de Transporte Aéreo</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>37</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#fdf97e</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjU3LW1ldGFkYWRvcy5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzYiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMTE4LjgyNjIzIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMzQyNyIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhOSI+PHJkZjpSREY+PGNjOldvcmsKICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZQogICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjxkYzpkYXRlPjwvZGM6ZGF0ZT48ZGM6Y3JlYXRvcj48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOmNyZWF0b3I+PGRjOnJpZ2h0cz48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOnJpZ2h0cz48ZGM6cHVibGlzaGVyPjxjYzpBZ2VudD48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOkFnZW50PjwvZGM6cHVibGlzaGVyPjxkYzpkZXNjcmlwdGlvbj48L2RjOmRlc2NyaXB0aW9uPjxjYzpsaWNlbnNlCiAgICAgICAgIHJkZjpyZXNvdXJjZT0iIiAvPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT4KPGRlZnMKICAgaWQ9ImRlZnMzIj4KPC9kZWZzPgo8cGF0aAogICBpZD0icGF0aDciCiAgIHN0cm9rZT0icGFyYW0ob3V0bGluZSkgIzAwMCIKICAgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSAxIgogICBkPSJtIDQ5OS45ODIzNiwyNTAuMDA4MiBjIDAuNTI1NTcsLTE1Ljg0NTQ2IC0xNi4wNDI4NywtMTcuODgzMTMgLTMzLjU1Njc1LC0yNi4yNjU5NCBsIDIyLjY5ODUsLTgzLjU2MzMgaCAtMjkuNDkzNDIgbCAtNDcuNzA3NzQsNzYuMzk5MjggYyAtMTkuMDU1MDQsLTYuNjQwNjIgLTc0LjA0NzcyLC04LjM3OTY1IC0xMjYuNzMwNjMsLTguMzc5NjUgTCAzMzcuMzgzMjUsLTIuM2UtNiBIIDI4MC42Mzg5OSBMIDE2Ny4zOTM1LDIwOS40OTY1MyBjIC00Ny4yODY4OSwwIC0xMDYuNTc3MDI3LDMuMjkxMjkgLTEyNS41MzUyNDksNS41NzQ4MyBDIDI0LjI3NDIyOCwyMTcuMjA0IDAsMjI1LjY0MDYzIDAsMjQ5Ljk5NzY1IGMgMCwyNC4zNTcwMiAyNC4yNzQyMjgsMzIuNzc2NzcgNDEuODU4MjUxLDM0Ljk0NDIzIDE4Ljk2NzExNCwyLjI0NjYgNzguMjUyMzA5LDUuNTM3ODkgMTI1LjUzNTI0OSw1LjUzNzg5IGwgMTEzLjI0NTQ5LDIwOS41MTc2NCBoIDU2Ljc0NDI2IEwgMjg1LjE5MjMyLDI5MS44MTk5MiBjIDUyLjY4MTkzLDAgMTA3LjY3MzYxLC0xLjc2MDEzIDEyNi43MzA2MywtOC4zODE3NiBsIDQ3LjcwNzc0LDc2LjQwMTM5IGggMjkuNDkzNDIgbCAtMjIuNjk4NSwtODMuNTg0NCBjIDE3LjUxNTg2LC04LjM2ODA0IDM0LjA4MzMxLC0xMC40MDQ2NSAzMy41NTk3MSwtMjYuMjQzNzggeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23000000&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjU3LW1ldGFkYWRvcy5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzYiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMTE4LjgyNjIzIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMzQyNyIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhOSI+PHJkZjpSREY+PGNjOldvcmsKICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZQogICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjxkYzpkYXRlPjwvZGM6ZGF0ZT48ZGM6Y3JlYXRvcj48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOmNyZWF0b3I+PGRjOnJpZ2h0cz48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOnJpZ2h0cz48ZGM6cHVibGlzaGVyPjxjYzpBZ2VudD48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOkFnZW50PjwvZGM6cHVibGlzaGVyPjxkYzpkZXNjcmlwdGlvbj48L2RjOmRlc2NyaXB0aW9uPjxjYzpsaWNlbnNlCiAgICAgICAgIHJkZjpyZXNvdXJjZT0iIiAvPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT4KPGRlZnMKICAgaWQ9ImRlZnMzIj4KPC9kZWZzPgo8cGF0aAogICBpZD0icGF0aDciCiAgIHN0cm9rZT0icGFyYW0ob3V0bGluZSkgIzAwMCIKICAgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSAxIgogICBkPSJtIDQ5OS45ODIzNiwyNTAuMDA4MiBjIDAuNTI1NTcsLTE1Ljg0NTQ2IC0xNi4wNDI4NywtMTcuODgzMTMgLTMzLjU1Njc1LC0yNi4yNjU5NCBsIDIyLjY5ODUsLTgzLjU2MzMgaCAtMjkuNDkzNDIgbCAtNDcuNzA3NzQsNzYuMzk5MjggYyAtMTkuMDU1MDQsLTYuNjQwNjIgLTc0LjA0NzcyLC04LjM3OTY1IC0xMjYuNzMwNjMsLTguMzc5NjUgTCAzMzcuMzgzMjUsLTIuM2UtNiBIIDI4MC42Mzg5OSBMIDE2Ny4zOTM1LDIwOS40OTY1MyBjIC00Ny4yODY4OSwwIC0xMDYuNTc3MDI3LDMuMjkxMjkgLTEyNS41MzUyNDksNS41NzQ4MyBDIDI0LjI3NDIyOCwyMTcuMjA0IDAsMjI1LjY0MDYzIDAsMjQ5Ljk5NzY1IGMgMCwyNC4zNTcwMiAyNC4yNzQyMjgsMzIuNzc2NzcgNDEuODU4MjUxLDM0Ljk0NDIzIDE4Ljk2NzExNCwyLjI0NjYgNzguMjUyMzA5LDUuNTM3ODkgMTI1LjUzNTI0OSw1LjUzNzg5IGwgMTEzLjI0NTQ5LDIwOS41MTc2NCBoIDU2Ljc0NDI2IEwgMjg1LjE5MjMyLDI5MS44MTk5MiBjIDUyLjY4MTkzLDAgMTA3LjY3MzYxLC0xLjc2MDEzIDEyNi43MzA2MywtOC4zODE3NiBsIDQ3LjcwNzc0LDc2LjQwMTM5IGggMjkuNDkzNDIgbCAtMjIuNjk4NSwtODMuNTg0NCBjIDE3LjUxNTg2LC04LjM2ODA0IDM0LjA4MzMxLC0xMC40MDQ2NSAzMy41NTk3MSwtMjYuMjQzNzggeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>19</se:Size>
              <se:Rotation>
                <ogc:Literal>90</ogc:Literal>
              </se:Rotation>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>38 - Infraestrutura de Transporte Aéreo Prevista</se:Name>
          <se:Description>
            <se:Title>38 - Infraestrutura de Transporte Aéreo Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>38</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjU3LW1ldGFkYWRvcy5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzYiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMTE4LjgyNjIzIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMzQyNyIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhOSI+PHJkZjpSREY+PGNjOldvcmsKICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZQogICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjxkYzpkYXRlPjwvZGM6ZGF0ZT48ZGM6Y3JlYXRvcj48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOmNyZWF0b3I+PGRjOnJpZ2h0cz48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOnJpZ2h0cz48ZGM6cHVibGlzaGVyPjxjYzpBZ2VudD48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOkFnZW50PjwvZGM6cHVibGlzaGVyPjxkYzpkZXNjcmlwdGlvbj48L2RjOmRlc2NyaXB0aW9uPjxjYzpsaWNlbnNlCiAgICAgICAgIHJkZjpyZXNvdXJjZT0iIiAvPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT4KPGRlZnMKICAgaWQ9ImRlZnMzIj4KPC9kZWZzPgo8cGF0aAogICBpZD0icGF0aDciCiAgIHN0cm9rZT0icGFyYW0ob3V0bGluZSkgIzAwMCIKICAgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSAxIgogICBkPSJtIDQ5OS45ODIzNiwyNTAuMDA4MiBjIDAuNTI1NTcsLTE1Ljg0NTQ2IC0xNi4wNDI4NywtMTcuODgzMTMgLTMzLjU1Njc1LC0yNi4yNjU5NCBsIDIyLjY5ODUsLTgzLjU2MzMgaCAtMjkuNDkzNDIgbCAtNDcuNzA3NzQsNzYuMzk5MjggYyAtMTkuMDU1MDQsLTYuNjQwNjIgLTc0LjA0NzcyLC04LjM3OTY1IC0xMjYuNzMwNjMsLTguMzc5NjUgTCAzMzcuMzgzMjUsLTIuM2UtNiBIIDI4MC42Mzg5OSBMIDE2Ny4zOTM1LDIwOS40OTY1MyBjIC00Ny4yODY4OSwwIC0xMDYuNTc3MDI3LDMuMjkxMjkgLTEyNS41MzUyNDksNS41NzQ4MyBDIDI0LjI3NDIyOCwyMTcuMjA0IDAsMjI1LjY0MDYzIDAsMjQ5Ljk5NzY1IGMgMCwyNC4zNTcwMiAyNC4yNzQyMjgsMzIuNzc2NzcgNDEuODU4MjUxLDM0Ljk0NDIzIDE4Ljk2NzExNCwyLjI0NjYgNzguMjUyMzA5LDUuNTM3ODkgMTI1LjUzNTI0OSw1LjUzNzg5IGwgMTEzLjI0NTQ5LDIwOS41MTc2NCBoIDU2Ljc0NDI2IEwgMjg1LjE5MjMyLDI5MS44MTk5MiBjIDUyLjY4MTkzLDAgMTA3LjY3MzYxLC0xLjc2MDEzIDEyNi43MzA2MywtOC4zODE3NiBsIDQ3LjcwNzc0LDc2LjQwMTM5IGggMjkuNDkzNDIgbCAtMjIuNjk4NSwtODMuNTg0NCBjIDE3LjUxNTg2LC04LjM2ODA0IDM0LjA4MzMxLC0xMC40MDQ2NSAzMy41NTk3MSwtMjYuMjQzNzggeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23000000&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjU3LW1ldGFkYWRvcy5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzYiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMTE4LjgyNjIzIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMzQyNyIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhOSI+PHJkZjpSREY+PGNjOldvcmsKICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZQogICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjxkYzpkYXRlPjwvZGM6ZGF0ZT48ZGM6Y3JlYXRvcj48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOmNyZWF0b3I+PGRjOnJpZ2h0cz48Y2M6QWdlbnQ+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpBZ2VudD48L2RjOnJpZ2h0cz48ZGM6cHVibGlzaGVyPjxjYzpBZ2VudD48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOkFnZW50PjwvZGM6cHVibGlzaGVyPjxkYzpkZXNjcmlwdGlvbj48L2RjOmRlc2NyaXB0aW9uPjxjYzpsaWNlbnNlCiAgICAgICAgIHJkZjpyZXNvdXJjZT0iIiAvPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT4KPGRlZnMKICAgaWQ9ImRlZnMzIj4KPC9kZWZzPgo8cGF0aAogICBpZD0icGF0aDciCiAgIHN0cm9rZT0icGFyYW0ob3V0bGluZSkgIzAwMCIKICAgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSAxIgogICBkPSJtIDQ5OS45ODIzNiwyNTAuMDA4MiBjIDAuNTI1NTcsLTE1Ljg0NTQ2IC0xNi4wNDI4NywtMTcuODgzMTMgLTMzLjU1Njc1LC0yNi4yNjU5NCBsIDIyLjY5ODUsLTgzLjU2MzMgaCAtMjkuNDkzNDIgbCAtNDcuNzA3NzQsNzYuMzk5MjggYyAtMTkuMDU1MDQsLTYuNjQwNjIgLTc0LjA0NzcyLC04LjM3OTY1IC0xMjYuNzMwNjMsLTguMzc5NjUgTCAzMzcuMzgzMjUsLTIuM2UtNiBIIDI4MC42Mzg5OSBMIDE2Ny4zOTM1LDIwOS40OTY1MyBjIC00Ny4yODY4OSwwIC0xMDYuNTc3MDI3LDMuMjkxMjkgLTEyNS41MzUyNDksNS41NzQ4MyBDIDI0LjI3NDIyOCwyMTcuMjA0IDAsMjI1LjY0MDYzIDAsMjQ5Ljk5NzY1IGMgMCwyNC4zNTcwMiAyNC4yNzQyMjgsMzIuNzc2NzcgNDEuODU4MjUxLDM0Ljk0NDIzIDE4Ljk2NzExNCwyLjI0NjYgNzguMjUyMzA5LDUuNTM3ODkgMTI1LjUzNTI0OSw1LjUzNzg5IGwgMTEzLjI0NTQ5LDIwOS41MTc2NCBoIDU2Ljc0NDI2IEwgMjg1LjE5MjMyLDI5MS44MTk5MiBjIDUyLjY4MTkzLDAgMTA3LjY3MzYxLC0xLjc2MDEzIDEyNi43MzA2MywtOC4zODE3NiBsIDQ3LjcwNzc0LDc2LjQwMTM5IGggMjkuNDkzNDIgbCAtMjIuNjk4NSwtODMuNTg0NCBjIDE3LjUxNTg2LC04LjM2ODA0IDM0LjA4MzMxLC0xMC40MDQ2NSAzMy41NTk3MSwtMjYuMjQzNzggeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>19</se:Size>
              <se:Rotation>
                <ogc:Literal>90</ogc:Literal>
              </se:Rotation>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>39 - Porto</se:Name>
          <se:Description>
            <se:Title>39 - Porto</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>39</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#22bff1</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzIiCiAgIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDU4MCA1ODAiCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIHZpZXdCb3g9IjAgMCA1MDAgNTAwIgogICBoZWlnaHQ9IjUwMCIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgaW5rc2NhcGU6dmVyc2lvbj0iMC40OC40IHI5OTM5IgogICBzb2RpcG9kaTpkb2NuYW1lPSI2My5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzkiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMjkwIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMiIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTUiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzNCI+CjwvZGVmcz4KPGcKICAgaWQ9ImxheWVyMyIKICAgdHJhbnNmb3JtPSJtYXRyaXgoNDguMTQ5NjksMCwwLDQ4LjE0OTY5LC01MzYuMjczMjcsLTExMy4zMDY3NSkiCiAgIGRpc3BsYXk9Im5vbmUiCiAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiM3NTc1NzU7c3Ryb2tlLXdpZHRoOjAuMTtkaXNwbGF5Om5vbmUiPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM0IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iMTAiCiAgIHdpZHRoPSIxMCIKICAgeT0iMSIKICAgeD0iMSIKICAgc3R5bGU9ImRpc3BsYXk6aW5saW5lIiAvPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM2IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iOCIKICAgd2lkdGg9IjgiCiAgIHk9IjIiCiAgIHg9IjIiCiAgIHN0eWxlPSJkaXNwbGF5OmlubGluZSIgLz4KPC9nPgo8cGF0aAogICBpZD0icGF0aDEzIgogICBzdHJva2U9InBhcmFtKG91dGxpbmUpICMwMDAiCiAgIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkgMSIKICAgZD0ibSA0OTkuMzEzOTksMzQ1LjQ0NTA5IC0xNi4yNzM2MSwtOTQuNDk1MzcgYyAtMS44MDg1NywtMTAuMDIwMjIgLTguNTkyNDIsLTE1LjAyOTI3IC0yMC4zNTE1NSwtMTUuMDI5MjcgLTUuNDM5NTYsMCAtMTAuNDE2LDIuMDg3OTkgLTE0LjkyODE3LDYuMjYzOTcgbCAtNzUuMzIxMDYsNjUuMDg1NjIgYyAtNS40MjQ1NCw0LjE2MzE5IC04LjEzNzM5LDkuMTY1ODUgLTguMTM2MjMsMTUuMDEwMDkgLTEwZS00LDEwLjAyMDIyIDQuOTc1MjgsMTYuNDg4NzIgMTQuOTI3MDEsMTkuNDA0NDUgbCAxOS4wMDYxLDUuNjMzMzEgYyAtOS40OTY3LDIzLjc4Mjg0IC0yNC42NDc3Niw0NC4xMjE1NyAtNDUuNDU0MzQsNjEuMDE2MTcgLTIwLjgwNzczLDE2Ljg5NTY3IC00NC43Nzg3MiwyNy44NDQ4MyAtNzEuOTE1MjgsMzIuODQ4NTUgViAxMzIuNjcxNSBjIDMwLjI5NTE5LC0xMi4xMDcxNSA0NS40NDUxLC0zMy4zODg2NjEgNDUuNDQ1MSwtNjMuODQzNDggMCwtMTguNzY2MzM5IC03LjM0OTc1LC0zNC45MzAxNDggLTIyLjA0OTI0LC00OC40ODkyOTcgQyAyODkuNTYyMDYsNi43Nzk1NzQzIDI3MS44MTEzNCwwIDI1MS4wMTE2OSwwIDIzMC42NTMyMSwwIDIxMy4xMjY1Myw2Ljc4MDYzOTYgMTk4LjQzNTEyLDIwLjMzODcyMyAxODMuNzQxNCwzMy44OTg5MzcgMTc2LjM5NjI3LDUwLjA2MTY4MSAxNzYuMzk2MjcsNjguODI4MDIgYyAwLDMwLjQ1NDgxOSAxNS4zNzUxMSw1MS43MzUyNyA0Ni4xMjc2NCw2My44NDM0OCBWIDQ0MS44MTExNCBDIDE5NC45MzIzMiw0MzYuODA3NDIgMTcwLjI4MTEsNDI1Ljg1NCAxNDguNTcwMjQsNDA4Ljk1MyAxMjYuODU4MjMsMzkyLjA1MiAxMTEuMjU0NDUsMzcxLjUwNjYxIDEwMS43NTg5LDM0Ny4zMTU3NiBsIDE5LjAwNjEsLTUuNjMzMzEgYyA5LjkzNjcxLC0yLjkxNTczIDE0LjkwNjIyLC05LjM4NDIzIDE0LjkwNjIyLC0xOS40MDQ0NSAwLC01LjQyMzQ1IC0yLjQ4NDE3LC0xMC40MjYxIC03LjQ1MzY4LC0xNS4wMTAwOSBMIDUyLjIzNDcyMSwyNDIuMTgyMjkgYyAtNC41MjcxODYsLTQuMTc1OTggLTkuNTAzNjI3LC02LjI2Mzk3IC0xNC45MjcwMTEsLTYuMjYzOTcgLTExLjc2MDI5LDAgLTE4LjU0NDE0LDUuMDEwMTEgLTIwLjM1MTU1LDE1LjAyOTI3IEwgMC42ODI1NDI2MiwzNDUuNDQyOTYgQyAwLjIyNjM1OTMxLDM0Ny41MTgxNyAwLDM0OC45NzU1IDAsMzQ5LjgxNjAyIDAsMzYzLjE3MTcgNy40NTk0NjMyLDM2OS44NDkgMjIuMzgwNjk5LDM2OS44NDkgYyAyLjI2MzU5NCwwIDQuMjk5NjcyLC0wLjIwOTg2IDYuMTA4MjM3LC0wLjYzMDY1IGwgMTcuNjM5ODU4LC01LjYzMjI1IGMgMTQuNDc4OTExLDQwLjA1NDI1IDQwLjM3MjgsNzIuODAyNjYgNzcuNjgwNTA2LDk4LjI0NzM3IEMgMTYxLjExNzAxLDQ4Ny4yNzgxOCAyMDMuMjkxNDUsNTAwIDI1MC4zMjc5OSw1MDAgYyA0Ni41ODI2NywwIDg4Ljg3Mzc1LC0xMi45Mjk1NiAxMjYuODc2NywtMzguNzg2NTQgMzYuNjMyMSwtMjUuMDMxMzcgNjIuMTg3NiwtNTcuNTczMTEgNzYuNjY2NTIsLTk3LjYyNzM2IGwgMTcuNjM5ODUsNS42MzIyNSBjIDEuODA3NDEsMC40MjA3OSAzLjg0MzQ5LDAuNjMwNjUgNi4xMDcwOSwwLjYzMDY1IDE0LjkyMDA4LDAgMjIuMzgwNywtNi42NzczIDIyLjM4MTg1LC0yMC4wMzI5OCAtMC4wMjMxLC0wLjgzMDkzIC0wLjI1NDA4LC0yLjI5MDM5IC0wLjcwNDQ5LC00LjM2NzczIHogTSAyNTEuMDExNjksOTcuNjM0ODE5IGMgLTguMTQzMTYsMCAtMTUuMjY4ODYsLTIuODE2NjU1IC0yMS4zNzU5NCwtOC40NTEwMzEgLTYuMTA4MjQsLTUuNjMzMzExIC05LjE2MTc4LC0xMi40MTYwODEgLTkuMTYxNzgsLTIwLjM0ODMxMSAwLC03LjUxMTQzNiAzLjA1MzU0LC0xNC4wODExNDYgOS4xNjE3OCwtMTkuNzA5MTMgNi4xMDcwOCwtNS42MjY5MTkgMTMuMjMyNzgsLTguNDQwMzc5IDIxLjM3NTk0LC04LjQ0MTQ0NCA4LjU5OTM0LDAgMTUuOTQ5MDksMi44MTQ1MjUgMjIuMDQ5MjQsOC40NDE0NDQgNi4xMDAxNSw1LjYyNzk4NCA5LjE1MTM5LDEyLjE5NzY5NCA5LjE1MTM5LDE5LjcwOTEzIDAsNy45MzIyMyAtMy4wNTEyNCwxNC43MTUgLTkuMTUxMzksMjAuMzQ4MzExIC02LjA5Nzg0LDUuNjM1NDQxIC0xMy40NTQ1Miw4LjQ0NzgzNSAtMjIuMDQ2OTMsOC40NDc4MzUgeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23000000&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzIiCiAgIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDU4MCA1ODAiCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIHZpZXdCb3g9IjAgMCA1MDAgNTAwIgogICBoZWlnaHQ9IjUwMCIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgaW5rc2NhcGU6dmVyc2lvbj0iMC40OC40IHI5OTM5IgogICBzb2RpcG9kaTpkb2NuYW1lPSI2My5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzkiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMjkwIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMiIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTUiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzNCI+CjwvZGVmcz4KPGcKICAgaWQ9ImxheWVyMyIKICAgdHJhbnNmb3JtPSJtYXRyaXgoNDguMTQ5NjksMCwwLDQ4LjE0OTY5LC01MzYuMjczMjcsLTExMy4zMDY3NSkiCiAgIGRpc3BsYXk9Im5vbmUiCiAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiM3NTc1NzU7c3Ryb2tlLXdpZHRoOjAuMTtkaXNwbGF5Om5vbmUiPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM0IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iMTAiCiAgIHdpZHRoPSIxMCIKICAgeT0iMSIKICAgeD0iMSIKICAgc3R5bGU9ImRpc3BsYXk6aW5saW5lIiAvPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM2IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iOCIKICAgd2lkdGg9IjgiCiAgIHk9IjIiCiAgIHg9IjIiCiAgIHN0eWxlPSJkaXNwbGF5OmlubGluZSIgLz4KPC9nPgo8cGF0aAogICBpZD0icGF0aDEzIgogICBzdHJva2U9InBhcmFtKG91dGxpbmUpICMwMDAiCiAgIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkgMSIKICAgZD0ibSA0OTkuMzEzOTksMzQ1LjQ0NTA5IC0xNi4yNzM2MSwtOTQuNDk1MzcgYyAtMS44MDg1NywtMTAuMDIwMjIgLTguNTkyNDIsLTE1LjAyOTI3IC0yMC4zNTE1NSwtMTUuMDI5MjcgLTUuNDM5NTYsMCAtMTAuNDE2LDIuMDg3OTkgLTE0LjkyODE3LDYuMjYzOTcgbCAtNzUuMzIxMDYsNjUuMDg1NjIgYyAtNS40MjQ1NCw0LjE2MzE5IC04LjEzNzM5LDkuMTY1ODUgLTguMTM2MjMsMTUuMDEwMDkgLTEwZS00LDEwLjAyMDIyIDQuOTc1MjgsMTYuNDg4NzIgMTQuOTI3MDEsMTkuNDA0NDUgbCAxOS4wMDYxLDUuNjMzMzEgYyAtOS40OTY3LDIzLjc4Mjg0IC0yNC42NDc3Niw0NC4xMjE1NyAtNDUuNDU0MzQsNjEuMDE2MTcgLTIwLjgwNzczLDE2Ljg5NTY3IC00NC43Nzg3MiwyNy44NDQ4MyAtNzEuOTE1MjgsMzIuODQ4NTUgViAxMzIuNjcxNSBjIDMwLjI5NTE5LC0xMi4xMDcxNSA0NS40NDUxLC0zMy4zODg2NjEgNDUuNDQ1MSwtNjMuODQzNDggMCwtMTguNzY2MzM5IC03LjM0OTc1LC0zNC45MzAxNDggLTIyLjA0OTI0LC00OC40ODkyOTcgQyAyODkuNTYyMDYsNi43Nzk1NzQzIDI3MS44MTEzNCwwIDI1MS4wMTE2OSwwIDIzMC42NTMyMSwwIDIxMy4xMjY1Myw2Ljc4MDYzOTYgMTk4LjQzNTEyLDIwLjMzODcyMyAxODMuNzQxNCwzMy44OTg5MzcgMTc2LjM5NjI3LDUwLjA2MTY4MSAxNzYuMzk2MjcsNjguODI4MDIgYyAwLDMwLjQ1NDgxOSAxNS4zNzUxMSw1MS43MzUyNyA0Ni4xMjc2NCw2My44NDM0OCBWIDQ0MS44MTExNCBDIDE5NC45MzIzMiw0MzYuODA3NDIgMTcwLjI4MTEsNDI1Ljg1NCAxNDguNTcwMjQsNDA4Ljk1MyAxMjYuODU4MjMsMzkyLjA1MiAxMTEuMjU0NDUsMzcxLjUwNjYxIDEwMS43NTg5LDM0Ny4zMTU3NiBsIDE5LjAwNjEsLTUuNjMzMzEgYyA5LjkzNjcxLC0yLjkxNTczIDE0LjkwNjIyLC05LjM4NDIzIDE0LjkwNjIyLC0xOS40MDQ0NSAwLC01LjQyMzQ1IC0yLjQ4NDE3LC0xMC40MjYxIC03LjQ1MzY4LC0xNS4wMTAwOSBMIDUyLjIzNDcyMSwyNDIuMTgyMjkgYyAtNC41MjcxODYsLTQuMTc1OTggLTkuNTAzNjI3LC02LjI2Mzk3IC0xNC45MjcwMTEsLTYuMjYzOTcgLTExLjc2MDI5LDAgLTE4LjU0NDE0LDUuMDEwMTEgLTIwLjM1MTU1LDE1LjAyOTI3IEwgMC42ODI1NDI2MiwzNDUuNDQyOTYgQyAwLjIyNjM1OTMxLDM0Ny41MTgxNyAwLDM0OC45NzU1IDAsMzQ5LjgxNjAyIDAsMzYzLjE3MTcgNy40NTk0NjMyLDM2OS44NDkgMjIuMzgwNjk5LDM2OS44NDkgYyAyLjI2MzU5NCwwIDQuMjk5NjcyLC0wLjIwOTg2IDYuMTA4MjM3LC0wLjYzMDY1IGwgMTcuNjM5ODU4LC01LjYzMjI1IGMgMTQuNDc4OTExLDQwLjA1NDI1IDQwLjM3MjgsNzIuODAyNjYgNzcuNjgwNTA2LDk4LjI0NzM3IEMgMTYxLjExNzAxLDQ4Ny4yNzgxOCAyMDMuMjkxNDUsNTAwIDI1MC4zMjc5OSw1MDAgYyA0Ni41ODI2NywwIDg4Ljg3Mzc1LC0xMi45Mjk1NiAxMjYuODc2NywtMzguNzg2NTQgMzYuNjMyMSwtMjUuMDMxMzcgNjIuMTg3NiwtNTcuNTczMTEgNzYuNjY2NTIsLTk3LjYyNzM2IGwgMTcuNjM5ODUsNS42MzIyNSBjIDEuODA3NDEsMC40MjA3OSAzLjg0MzQ5LDAuNjMwNjUgNi4xMDcwOSwwLjYzMDY1IDE0LjkyMDA4LDAgMjIuMzgwNywtNi42NzczIDIyLjM4MTg1LC0yMC4wMzI5OCAtMC4wMjMxLC0wLjgzMDkzIC0wLjI1NDA4LC0yLjI5MDM5IC0wLjcwNDQ5LC00LjM2NzczIHogTSAyNTEuMDExNjksOTcuNjM0ODE5IGMgLTguMTQzMTYsMCAtMTUuMjY4ODYsLTIuODE2NjU1IC0yMS4zNzU5NCwtOC40NTEwMzEgLTYuMTA4MjQsLTUuNjMzMzExIC05LjE2MTc4LC0xMi40MTYwODEgLTkuMTYxNzgsLTIwLjM0ODMxMSAwLC03LjUxMTQzNiAzLjA1MzU0LC0xNC4wODExNDYgOS4xNjE3OCwtMTkuNzA5MTMgNi4xMDcwOCwtNS42MjY5MTkgMTMuMjMyNzgsLTguNDQwMzc5IDIxLjM3NTk0LC04LjQ0MTQ0NCA4LjU5OTM0LDAgMTUuOTQ5MDksMi44MTQ1MjUgMjIuMDQ5MjQsOC40NDE0NDQgNi4xMDAxNSw1LjYyNzk4NCA5LjE1MTM5LDEyLjE5NzY5NCA5LjE1MTM5LDE5LjcwOTEzIDAsNy45MzIyMyAtMy4wNTEyNCwxNC43MTUgLTkuMTUxMzksMjAuMzQ4MzExIC02LjA5Nzg0LDUuNjM1NDQxIC0xMy40NTQ1Miw4LjQ0NzgzNSAtMjIuMDQ2OTMsOC40NDc4MzUgeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>19</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>40 - Porto Previsto</se:Name>
          <se:Description>
            <se:Title>40 - Porto Previsto</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>40</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzIiCiAgIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDU4MCA1ODAiCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIHZpZXdCb3g9IjAgMCA1MDAgNTAwIgogICBoZWlnaHQ9IjUwMCIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgaW5rc2NhcGU6dmVyc2lvbj0iMC40OC40IHI5OTM5IgogICBzb2RpcG9kaTpkb2NuYW1lPSI2My5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzkiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMjkwIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMiIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTUiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzNCI+CjwvZGVmcz4KPGcKICAgaWQ9ImxheWVyMyIKICAgdHJhbnNmb3JtPSJtYXRyaXgoNDguMTQ5NjksMCwwLDQ4LjE0OTY5LC01MzYuMjczMjcsLTExMy4zMDY3NSkiCiAgIGRpc3BsYXk9Im5vbmUiCiAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiM3NTc1NzU7c3Ryb2tlLXdpZHRoOjAuMTtkaXNwbGF5Om5vbmUiPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM0IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iMTAiCiAgIHdpZHRoPSIxMCIKICAgeT0iMSIKICAgeD0iMSIKICAgc3R5bGU9ImRpc3BsYXk6aW5saW5lIiAvPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM2IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iOCIKICAgd2lkdGg9IjgiCiAgIHk9IjIiCiAgIHg9IjIiCiAgIHN0eWxlPSJkaXNwbGF5OmlubGluZSIgLz4KPC9nPgo8cGF0aAogICBpZD0icGF0aDEzIgogICBzdHJva2U9InBhcmFtKG91dGxpbmUpICMwMDAiCiAgIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkgMSIKICAgZD0ibSA0OTkuMzEzOTksMzQ1LjQ0NTA5IC0xNi4yNzM2MSwtOTQuNDk1MzcgYyAtMS44MDg1NywtMTAuMDIwMjIgLTguNTkyNDIsLTE1LjAyOTI3IC0yMC4zNTE1NSwtMTUuMDI5MjcgLTUuNDM5NTYsMCAtMTAuNDE2LDIuMDg3OTkgLTE0LjkyODE3LDYuMjYzOTcgbCAtNzUuMzIxMDYsNjUuMDg1NjIgYyAtNS40MjQ1NCw0LjE2MzE5IC04LjEzNzM5LDkuMTY1ODUgLTguMTM2MjMsMTUuMDEwMDkgLTEwZS00LDEwLjAyMDIyIDQuOTc1MjgsMTYuNDg4NzIgMTQuOTI3MDEsMTkuNDA0NDUgbCAxOS4wMDYxLDUuNjMzMzEgYyAtOS40OTY3LDIzLjc4Mjg0IC0yNC42NDc3Niw0NC4xMjE1NyAtNDUuNDU0MzQsNjEuMDE2MTcgLTIwLjgwNzczLDE2Ljg5NTY3IC00NC43Nzg3MiwyNy44NDQ4MyAtNzEuOTE1MjgsMzIuODQ4NTUgViAxMzIuNjcxNSBjIDMwLjI5NTE5LC0xMi4xMDcxNSA0NS40NDUxLC0zMy4zODg2NjEgNDUuNDQ1MSwtNjMuODQzNDggMCwtMTguNzY2MzM5IC03LjM0OTc1LC0zNC45MzAxNDggLTIyLjA0OTI0LC00OC40ODkyOTcgQyAyODkuNTYyMDYsNi43Nzk1NzQzIDI3MS44MTEzNCwwIDI1MS4wMTE2OSwwIDIzMC42NTMyMSwwIDIxMy4xMjY1Myw2Ljc4MDYzOTYgMTk4LjQzNTEyLDIwLjMzODcyMyAxODMuNzQxNCwzMy44OTg5MzcgMTc2LjM5NjI3LDUwLjA2MTY4MSAxNzYuMzk2MjcsNjguODI4MDIgYyAwLDMwLjQ1NDgxOSAxNS4zNzUxMSw1MS43MzUyNyA0Ni4xMjc2NCw2My44NDM0OCBWIDQ0MS44MTExNCBDIDE5NC45MzIzMiw0MzYuODA3NDIgMTcwLjI4MTEsNDI1Ljg1NCAxNDguNTcwMjQsNDA4Ljk1MyAxMjYuODU4MjMsMzkyLjA1MiAxMTEuMjU0NDUsMzcxLjUwNjYxIDEwMS43NTg5LDM0Ny4zMTU3NiBsIDE5LjAwNjEsLTUuNjMzMzEgYyA5LjkzNjcxLC0yLjkxNTczIDE0LjkwNjIyLC05LjM4NDIzIDE0LjkwNjIyLC0xOS40MDQ0NSAwLC01LjQyMzQ1IC0yLjQ4NDE3LC0xMC40MjYxIC03LjQ1MzY4LC0xNS4wMTAwOSBMIDUyLjIzNDcyMSwyNDIuMTgyMjkgYyAtNC41MjcxODYsLTQuMTc1OTggLTkuNTAzNjI3LC02LjI2Mzk3IC0xNC45MjcwMTEsLTYuMjYzOTcgLTExLjc2MDI5LDAgLTE4LjU0NDE0LDUuMDEwMTEgLTIwLjM1MTU1LDE1LjAyOTI3IEwgMC42ODI1NDI2MiwzNDUuNDQyOTYgQyAwLjIyNjM1OTMxLDM0Ny41MTgxNyAwLDM0OC45NzU1IDAsMzQ5LjgxNjAyIDAsMzYzLjE3MTcgNy40NTk0NjMyLDM2OS44NDkgMjIuMzgwNjk5LDM2OS44NDkgYyAyLjI2MzU5NCwwIDQuMjk5NjcyLC0wLjIwOTg2IDYuMTA4MjM3LC0wLjYzMDY1IGwgMTcuNjM5ODU4LC01LjYzMjI1IGMgMTQuNDc4OTExLDQwLjA1NDI1IDQwLjM3MjgsNzIuODAyNjYgNzcuNjgwNTA2LDk4LjI0NzM3IEMgMTYxLjExNzAxLDQ4Ny4yNzgxOCAyMDMuMjkxNDUsNTAwIDI1MC4zMjc5OSw1MDAgYyA0Ni41ODI2NywwIDg4Ljg3Mzc1LC0xMi45Mjk1NiAxMjYuODc2NywtMzguNzg2NTQgMzYuNjMyMSwtMjUuMDMxMzcgNjIuMTg3NiwtNTcuNTczMTEgNzYuNjY2NTIsLTk3LjYyNzM2IGwgMTcuNjM5ODUsNS42MzIyNSBjIDEuODA3NDEsMC40MjA3OSAzLjg0MzQ5LDAuNjMwNjUgNi4xMDcwOSwwLjYzMDY1IDE0LjkyMDA4LDAgMjIuMzgwNywtNi42NzczIDIyLjM4MTg1LC0yMC4wMzI5OCAtMC4wMjMxLC0wLjgzMDkzIC0wLjI1NDA4LC0yLjI5MDM5IC0wLjcwNDQ5LC00LjM2NzczIHogTSAyNTEuMDExNjksOTcuNjM0ODE5IGMgLTguMTQzMTYsMCAtMTUuMjY4ODYsLTIuODE2NjU1IC0yMS4zNzU5NCwtOC40NTEwMzEgLTYuMTA4MjQsLTUuNjMzMzExIC05LjE2MTc4LC0xMi40MTYwODEgLTkuMTYxNzgsLTIwLjM0ODMxMSAwLC03LjUxMTQzNiAzLjA1MzU0LC0xNC4wODExNDYgOS4xNjE3OCwtMTkuNzA5MTMgNi4xMDcwOCwtNS42MjY5MTkgMTMuMjMyNzgsLTguNDQwMzc5IDIxLjM3NTk0LC04LjQ0MTQ0NCA4LjU5OTM0LDAgMTUuOTQ5MDksMi44MTQ1MjUgMjIuMDQ5MjQsOC40NDE0NDQgNi4xMDAxNSw1LjYyNzk4NCA5LjE1MTM5LDEyLjE5NzY5NCA5LjE1MTM5LDE5LjcwOTEzIDAsNy45MzIyMyAtMy4wNTEyNCwxNC43MTUgLTkuMTUxMzksMjAuMzQ4MzExIC02LjA5Nzg0LDUuNjM1NDQxIC0xMy40NTQ1Miw4LjQ0NzgzNSAtMjIuMDQ2OTMsOC40NDc4MzUgeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23000000&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzIiCiAgIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDU4MCA1ODAiCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIHZpZXdCb3g9IjAgMCA1MDAgNTAwIgogICBoZWlnaHQ9IjUwMCIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgaW5rc2NhcGU6dmVyc2lvbj0iMC40OC40IHI5OTM5IgogICBzb2RpcG9kaTpkb2NuYW1lPSI2My5zdmciPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTY4MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAyNCIKICAgaWQ9Im5hbWVkdmlldzkiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMS4xNTA4NzcyIgogICBpbmtzY2FwZTpjeD0iMjkwIgogICBpbmtzY2FwZTpjeT0iMjkwIgogICBpbmtzY2FwZTp3aW5kb3cteD0iLTQiCiAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMSIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ic3ZnMiIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTUiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzNCI+CjwvZGVmcz4KPGcKICAgaWQ9ImxheWVyMyIKICAgdHJhbnNmb3JtPSJtYXRyaXgoNDguMTQ5NjksMCwwLDQ4LjE0OTY5LC01MzYuMjczMjcsLTExMy4zMDY3NSkiCiAgIGRpc3BsYXk9Im5vbmUiCiAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiM3NTc1NzU7c3Ryb2tlLXdpZHRoOjAuMTtkaXNwbGF5Om5vbmUiPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM0IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iMTAiCiAgIHdpZHRoPSIxMCIKICAgeT0iMSIKICAgeD0iMSIKICAgc3R5bGU9ImRpc3BsYXk6aW5saW5lIiAvPgoJPHJlY3QKICAgaWQ9InJlY3Q0MTM2IgogICBkaXNwbGF5PSJpbmxpbmUiCiAgIGhlaWdodD0iOCIKICAgd2lkdGg9IjgiCiAgIHk9IjIiCiAgIHg9IjIiCiAgIHN0eWxlPSJkaXNwbGF5OmlubGluZSIgLz4KPC9nPgo8cGF0aAogICBpZD0icGF0aDEzIgogICBzdHJva2U9InBhcmFtKG91dGxpbmUpICMwMDAiCiAgIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkgMSIKICAgZD0ibSA0OTkuMzEzOTksMzQ1LjQ0NTA5IC0xNi4yNzM2MSwtOTQuNDk1MzcgYyAtMS44MDg1NywtMTAuMDIwMjIgLTguNTkyNDIsLTE1LjAyOTI3IC0yMC4zNTE1NSwtMTUuMDI5MjcgLTUuNDM5NTYsMCAtMTAuNDE2LDIuMDg3OTkgLTE0LjkyODE3LDYuMjYzOTcgbCAtNzUuMzIxMDYsNjUuMDg1NjIgYyAtNS40MjQ1NCw0LjE2MzE5IC04LjEzNzM5LDkuMTY1ODUgLTguMTM2MjMsMTUuMDEwMDkgLTEwZS00LDEwLjAyMDIyIDQuOTc1MjgsMTYuNDg4NzIgMTQuOTI3MDEsMTkuNDA0NDUgbCAxOS4wMDYxLDUuNjMzMzEgYyAtOS40OTY3LDIzLjc4Mjg0IC0yNC42NDc3Niw0NC4xMjE1NyAtNDUuNDU0MzQsNjEuMDE2MTcgLTIwLjgwNzczLDE2Ljg5NTY3IC00NC43Nzg3MiwyNy44NDQ4MyAtNzEuOTE1MjgsMzIuODQ4NTUgViAxMzIuNjcxNSBjIDMwLjI5NTE5LC0xMi4xMDcxNSA0NS40NDUxLC0zMy4zODg2NjEgNDUuNDQ1MSwtNjMuODQzNDggMCwtMTguNzY2MzM5IC03LjM0OTc1LC0zNC45MzAxNDggLTIyLjA0OTI0LC00OC40ODkyOTcgQyAyODkuNTYyMDYsNi43Nzk1NzQzIDI3MS44MTEzNCwwIDI1MS4wMTE2OSwwIDIzMC42NTMyMSwwIDIxMy4xMjY1Myw2Ljc4MDYzOTYgMTk4LjQzNTEyLDIwLjMzODcyMyAxODMuNzQxNCwzMy44OTg5MzcgMTc2LjM5NjI3LDUwLjA2MTY4MSAxNzYuMzk2MjcsNjguODI4MDIgYyAwLDMwLjQ1NDgxOSAxNS4zNzUxMSw1MS43MzUyNyA0Ni4xMjc2NCw2My44NDM0OCBWIDQ0MS44MTExNCBDIDE5NC45MzIzMiw0MzYuODA3NDIgMTcwLjI4MTEsNDI1Ljg1NCAxNDguNTcwMjQsNDA4Ljk1MyAxMjYuODU4MjMsMzkyLjA1MiAxMTEuMjU0NDUsMzcxLjUwNjYxIDEwMS43NTg5LDM0Ny4zMTU3NiBsIDE5LjAwNjEsLTUuNjMzMzEgYyA5LjkzNjcxLC0yLjkxNTczIDE0LjkwNjIyLC05LjM4NDIzIDE0LjkwNjIyLC0xOS40MDQ0NSAwLC01LjQyMzQ1IC0yLjQ4NDE3LC0xMC40MjYxIC03LjQ1MzY4LC0xNS4wMTAwOSBMIDUyLjIzNDcyMSwyNDIuMTgyMjkgYyAtNC41MjcxODYsLTQuMTc1OTggLTkuNTAzNjI3LC02LjI2Mzk3IC0xNC45MjcwMTEsLTYuMjYzOTcgLTExLjc2MDI5LDAgLTE4LjU0NDE0LDUuMDEwMTEgLTIwLjM1MTU1LDE1LjAyOTI3IEwgMC42ODI1NDI2MiwzNDUuNDQyOTYgQyAwLjIyNjM1OTMxLDM0Ny41MTgxNyAwLDM0OC45NzU1IDAsMzQ5LjgxNjAyIDAsMzYzLjE3MTcgNy40NTk0NjMyLDM2OS44NDkgMjIuMzgwNjk5LDM2OS44NDkgYyAyLjI2MzU5NCwwIDQuMjk5NjcyLC0wLjIwOTg2IDYuMTA4MjM3LC0wLjYzMDY1IGwgMTcuNjM5ODU4LC01LjYzMjI1IGMgMTQuNDc4OTExLDQwLjA1NDI1IDQwLjM3MjgsNzIuODAyNjYgNzcuNjgwNTA2LDk4LjI0NzM3IEMgMTYxLjExNzAxLDQ4Ny4yNzgxOCAyMDMuMjkxNDUsNTAwIDI1MC4zMjc5OSw1MDAgYyA0Ni41ODI2NywwIDg4Ljg3Mzc1LC0xMi45Mjk1NiAxMjYuODc2NywtMzguNzg2NTQgMzYuNjMyMSwtMjUuMDMxMzcgNjIuMTg3NiwtNTcuNTczMTEgNzYuNjY2NTIsLTk3LjYyNzM2IGwgMTcuNjM5ODUsNS42MzIyNSBjIDEuODA3NDEsMC40MjA3OSAzLjg0MzQ5LDAuNjMwNjUgNi4xMDcwOSwwLjYzMDY1IDE0LjkyMDA4LDAgMjIuMzgwNywtNi42NzczIDIyLjM4MTg1LC0yMC4wMzI5OCAtMC4wMjMxLC0wLjgzMDkzIC0wLjI1NDA4LC0yLjI5MDM5IC0wLjcwNDQ5LC00LjM2NzczIHogTSAyNTEuMDExNjksOTcuNjM0ODE5IGMgLTguMTQzMTYsMCAtMTUuMjY4ODYsLTIuODE2NjU1IC0yMS4zNzU5NCwtOC40NTEwMzEgLTYuMTA4MjQsLTUuNjMzMzExIC05LjE2MTc4LC0xMi40MTYwODEgLTkuMTYxNzgsLTIwLjM0ODMxMSAwLC03LjUxMTQzNiAzLjA1MzU0LC0xNC4wODExNDYgOS4xNjE3OCwtMTkuNzA5MTMgNi4xMDcwOCwtNS42MjY5MTkgMTMuMjMyNzgsLTguNDQwMzc5IDIxLjM3NTk0LC04LjQ0MTQ0NCA4LjU5OTM0LDAgMTUuOTQ5MDksMi44MTQ1MjUgMjIuMDQ5MjQsOC40NDE0NDQgNi4xMDAxNSw1LjYyNzk4NCA5LjE1MTM5LDEyLjE5NzY5NCA5LjE1MTM5LDE5LjcwOTEzIDAsNy45MzIyMyAtMy4wNTEyNCwxNC43MTUgLTkuMTUxMzksMjAuMzQ4MzExIC02LjA5Nzg0LDUuNjM1NDQxIC0xMy40NTQ1Miw4LjQ0NzgzNSAtMjIuMDQ2OTMsOC40NDc4MzUgeiIKICAgZmlsbD0icGFyYW0oZmlsbCkgI0ZGRiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>19</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>41 - Captação, Tratamento ou Armazenamento de Água</se:Name>
          <se:Description>
            <se:Title>41 - Captação, Tratamento ou Armazenamento de Água</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>41</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#71f4f4</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#71f4f4</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>42 - Captação, Tratamento ou Armazenamento de Água Prevista</se:Name>
          <se:Description>
            <se:Title>42 - Captação, Tratamento ou Armazenamento de Água Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>42</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#71f4f4</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>45 - Bombagem ou Tratamento de Águas Residuais</se:Name>
          <se:Description>
            <se:Title>45 - Bombagem ou Tratamento de Águas Residuais</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>45</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#8306ff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#8306ff</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>46 - Bombagem ou Tratamento de Águas Residuais Prevista</se:Name>
          <se:Description>
            <se:Title>46 - Bombagem ou Tratamento de Águas Residuais Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>46</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#8306ff</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>47 - Estação de Tratamento de Resíduos Sólidos</se:Name>
          <se:Description>
            <se:Title>47 - Estação de Tratamento de Resíduos Sólidos</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>47</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#a84040</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#a84040</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>48 - Estação de Tratamento de Resíduos Sólidos Prevista</se:Name>
          <se:Description>
            <se:Title>48 - Estação de Tratamento de Resíduos Sólidos Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>48</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>rectangle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#a84040</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>36</se:Size>
              <se:VendorOption name="widthHeightFactor">2</se:VendorOption>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>49 - Infraestrutura de Produção ou Transformação de Energia Elétrica</se:Name>
          <se:Description>
            <se:Title>49 - Infraestrutura de Produção ou Transformação de Energia Elétrica</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>49</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>diamond</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#bf0000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjgzLnN2ZyI+PHNvZGlwb2RpOm5hbWVkdmlldwogICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICBib3JkZXJvcGFjaXR5PSIxIgogICBvYmplY3R0b2xlcmFuY2U9IjEwIgogICBncmlkdG9sZXJhbmNlPSIxMCIKICAgZ3VpZGV0b2xlcmFuY2U9IjEwIgogICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMCIKICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgaW5rc2NhcGU6d2luZG93LXdpZHRoPSIxNjgwIgogICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSIxMDI0IgogICBpZD0ibmFtZWR2aWV3NiIKICAgc2hvd2dyaWQ9ImZhbHNlIgogICBpbmtzY2FwZTp6b29tPSIxLjE1MDg3NzIiCiAgIGlua3NjYXBlOmN4PSIyOTAiCiAgIGlua3NjYXBlOmN5PSIyOTAiCiAgIGlua3NjYXBlOndpbmRvdy14PSItNCIKICAgaW5rc2NhcGU6d2luZG93LXk9Ii00IgogICBpbmtzY2FwZTp3aW5kb3ctbWF4aW1pemVkPSIxIgogICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJzdmczNDI3Ij48aW5rc2NhcGU6Z3JpZAogICAgIHR5cGU9Inh5Z3JpZCIKICAgICBpZD0iZ3JpZDI5ODMiCiAgICAgdW5pdHM9Im1tIgogICAgIGVtcHNwYWNpbmc9IjUiCiAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICBlbmFibGVkPSJ0cnVlIgogICAgIHNuYXB2aXNpYmxlZ3JpZGxpbmVzb25seT0idHJ1ZSIgLz48L3NvZGlwb2RpOm5hbWVkdmlldz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTIiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzMyI+CjwvZGVmcz4KPHBhdGgKICAgaWQ9InBhdGgzMDAwIgogICBzdHlsZT0iZmlsbDpwYXJhbShmaWxsKSAjRkZGO2ZpbGwtb3BhY2l0eToxIgogICBkPSJNIDk5Ljk5OTQ4MiwxNjYuNjYxODggMjQ5Ljk5ODcsMCBsIDE0OS45OTkyMywwIC05OS45OTg1NCwxMjQuOTk5MzUgOTkuOTk4NTQsMCAtOTkuOTk4NTQsMTI0Ljk5OTM1IDc0Ljk5OTYxLDAgLTI1MC4wMDM0MSwyNDkuOTk4NzEgOTkuOTk4NTQsLTIwOC4zMzYxNyAtOTkuOTk4NTQsMCA5OS45OTg1NCwtMTI0Ljk5OTM2IHoiCiAgIGlua3NjYXBlOmNvbm5lY3Rvci1jdXJ2YXR1cmU9IjAiIC8+PC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23ffffff&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjgzLnN2ZyI+PHNvZGlwb2RpOm5hbWVkdmlldwogICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICBib3JkZXJvcGFjaXR5PSIxIgogICBvYmplY3R0b2xlcmFuY2U9IjEwIgogICBncmlkdG9sZXJhbmNlPSIxMCIKICAgZ3VpZGV0b2xlcmFuY2U9IjEwIgogICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMCIKICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgaW5rc2NhcGU6d2luZG93LXdpZHRoPSIxNjgwIgogICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSIxMDI0IgogICBpZD0ibmFtZWR2aWV3NiIKICAgc2hvd2dyaWQ9ImZhbHNlIgogICBpbmtzY2FwZTp6b29tPSIxLjE1MDg3NzIiCiAgIGlua3NjYXBlOmN4PSIyOTAiCiAgIGlua3NjYXBlOmN5PSIyOTAiCiAgIGlua3NjYXBlOndpbmRvdy14PSItNCIKICAgaW5rc2NhcGU6d2luZG93LXk9Ii00IgogICBpbmtzY2FwZTp3aW5kb3ctbWF4aW1pemVkPSIxIgogICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJzdmczNDI3Ij48aW5rc2NhcGU6Z3JpZAogICAgIHR5cGU9Inh5Z3JpZCIKICAgICBpZD0iZ3JpZDI5ODMiCiAgICAgdW5pdHM9Im1tIgogICAgIGVtcHNwYWNpbmc9IjUiCiAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICBlbmFibGVkPSJ0cnVlIgogICAgIHNuYXB2aXNpYmxlZ3JpZGxpbmVzb25seT0idHJ1ZSIgLz48L3NvZGlwb2RpOm5hbWVkdmlldz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTIiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzMyI+CjwvZGVmcz4KPHBhdGgKICAgaWQ9InBhdGgzMDAwIgogICBzdHlsZT0iZmlsbDpwYXJhbShmaWxsKSAjRkZGO2ZpbGwtb3BhY2l0eToxIgogICBkPSJNIDk5Ljk5OTQ4MiwxNjYuNjYxODggMjQ5Ljk5ODcsMCBsIDE0OS45OTkyMywwIC05OS45OTg1NCwxMjQuOTk5MzUgOTkuOTk4NTQsMCAtOTkuOTk4NTQsMTI0Ljk5OTM1IDc0Ljk5OTYxLDAgLTI1MC4wMDM0MSwyNDkuOTk4NzEgOTkuOTk4NTQsLTIwOC4zMzYxNyAtOTkuOTk4NTQsMCA5OS45OTg1NCwtMTI0Ljk5OTM2IHoiCiAgIGlua3NjYXBlOmNvbm5lY3Rvci1jdXJ2YXR1cmU9IjAiIC8+PC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#ffffff</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>50 - Infraestrutura de Produção ou Transformação de Energia Elétrica Prevista</se:Name>
          <se:Description>
            <se:Title>50 - Infraestrutura de Produção ou Transformação de Energia Elétrica Prevista</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>50</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>diamond</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">2</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>22</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjgzLnN2ZyI+PHNvZGlwb2RpOm5hbWVkdmlldwogICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICBib3JkZXJvcGFjaXR5PSIxIgogICBvYmplY3R0b2xlcmFuY2U9IjEwIgogICBncmlkdG9sZXJhbmNlPSIxMCIKICAgZ3VpZGV0b2xlcmFuY2U9IjEwIgogICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMCIKICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgaW5rc2NhcGU6d2luZG93LXdpZHRoPSIxNjgwIgogICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSIxMDI0IgogICBpZD0ibmFtZWR2aWV3NiIKICAgc2hvd2dyaWQ9ImZhbHNlIgogICBpbmtzY2FwZTp6b29tPSIxLjE1MDg3NzIiCiAgIGlua3NjYXBlOmN4PSIyOTAiCiAgIGlua3NjYXBlOmN5PSIyOTAiCiAgIGlua3NjYXBlOndpbmRvdy14PSItNCIKICAgaW5rc2NhcGU6d2luZG93LXk9Ii00IgogICBpbmtzY2FwZTp3aW5kb3ctbWF4aW1pemVkPSIxIgogICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJzdmczNDI3Ij48aW5rc2NhcGU6Z3JpZAogICAgIHR5cGU9Inh5Z3JpZCIKICAgICBpZD0iZ3JpZDI5ODMiCiAgICAgdW5pdHM9Im1tIgogICAgIGVtcHNwYWNpbmc9IjUiCiAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICBlbmFibGVkPSJ0cnVlIgogICAgIHNuYXB2aXNpYmxlZ3JpZGxpbmVzb25seT0idHJ1ZSIgLz48L3NvZGlwb2RpOm5hbWVkdmlldz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTIiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzMyI+CjwvZGVmcz4KPHBhdGgKICAgaWQ9InBhdGgzMDAwIgogICBzdHlsZT0iZmlsbDpwYXJhbShmaWxsKSAjRkZGO2ZpbGwtb3BhY2l0eToxIgogICBkPSJNIDk5Ljk5OTQ4MiwxNjYuNjYxODggMjQ5Ljk5ODcsMCBsIDE0OS45OTkyMywwIC05OS45OTg1NCwxMjQuOTk5MzUgOTkuOTk4NTQsMCAtOTkuOTk4NTQsMTI0Ljk5OTM1IDc0Ljk5OTYxLDAgLTI1MC4wMDM0MSwyNDkuOTk4NzEgOTkuOTk4NTQsLTIwOC4zMzYxNyAtOTkuOTk4NTQsMCA5OS45OTg1NCwtMTI0Ljk5OTM2IHoiCiAgIGlua3NjYXBlOmNvbm5lY3Rvci1jdXJ2YXR1cmU9IjAiIC8+PC9zdmc+Cg==?fill=%23000000&amp;fill-opacity=1&amp;outline=%23ffffff&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaWQ9InN2ZzM0MjciCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIGhlaWdodD0iNTAwIgogICB2aWV3Qm94PSIwIDAgNDk5Ljk5NzQxIDQ5OS45OTc0MSIKICAgd2lkdGg9IjUwMCIKICAgdmVyc2lvbj0iMS4xIgogICB5PSIwcHgiCiAgIHg9IjBweCIKICAgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTc5Ljk5NyA1NzkuOTk3IgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ4LjQgcjk5MzkiCiAgIHNvZGlwb2RpOmRvY25hbWU9IjgzLnN2ZyI+PHNvZGlwb2RpOm5hbWVkdmlldwogICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICBib3JkZXJvcGFjaXR5PSIxIgogICBvYmplY3R0b2xlcmFuY2U9IjEwIgogICBncmlkdG9sZXJhbmNlPSIxMCIKICAgZ3VpZGV0b2xlcmFuY2U9IjEwIgogICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMCIKICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgaW5rc2NhcGU6d2luZG93LXdpZHRoPSIxNjgwIgogICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSIxMDI0IgogICBpZD0ibmFtZWR2aWV3NiIKICAgc2hvd2dyaWQ9ImZhbHNlIgogICBpbmtzY2FwZTp6b29tPSIxLjE1MDg3NzIiCiAgIGlua3NjYXBlOmN4PSIyOTAiCiAgIGlua3NjYXBlOmN5PSIyOTAiCiAgIGlua3NjYXBlOndpbmRvdy14PSItNCIKICAgaW5rc2NhcGU6d2luZG93LXk9Ii00IgogICBpbmtzY2FwZTp3aW5kb3ctbWF4aW1pemVkPSIxIgogICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJzdmczNDI3Ij48aW5rc2NhcGU6Z3JpZAogICAgIHR5cGU9Inh5Z3JpZCIKICAgICBpZD0iZ3JpZDI5ODMiCiAgICAgdW5pdHM9Im1tIgogICAgIGVtcHNwYWNpbmc9IjUiCiAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICBlbmFibGVkPSJ0cnVlIgogICAgIHNuYXB2aXNpYmxlZ3JpZGxpbmVzb25seT0idHJ1ZSIgLz48L3NvZGlwb2RpOm5hbWVkdmlldz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMTIiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+PC9kYzp0aXRsZT48L2NjOldvcms+PC9yZGY6UkRGPjwvbWV0YWRhdGE+CjxkZWZzCiAgIGlkPSJkZWZzMyI+CjwvZGVmcz4KPHBhdGgKICAgaWQ9InBhdGgzMDAwIgogICBzdHlsZT0iZmlsbDpwYXJhbShmaWxsKSAjRkZGO2ZpbGwtb3BhY2l0eToxIgogICBkPSJNIDk5Ljk5OTQ4MiwxNjYuNjYxODggMjQ5Ljk5ODcsMCBsIDE0OS45OTkyMywwIC05OS45OTg1NCwxMjQuOTk5MzUgOTkuOTk4NTQsMCAtOTkuOTk4NTQsMTI0Ljk5OTM1IDc0Ljk5OTYxLDAgLTI1MC4wMDM0MSwyNDkuOTk4NzEgOTkuOTk4NTQsLTIwOC4zMzYxNyAtOTkuOTk4NTQsMCA5OS45OTg1NCwtMTI0Ljk5OTM2IHoiCiAgIGlua3NjYXBlOmNvbm5lY3Rvci1jdXJ2YXR1cmU9IjAiIC8+PC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#ffffff</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>13</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>146 - Estacionamento</se:Name>
          <se:Description>
            <se:Title>146 - Estacionamento</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>146</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer FilledMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>147 - Estacionamento Previsto</se:Name>
          <se:Description>
            <se:Title>147 - Estacionamento Previsto</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>147</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer FilledMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>150 - Imóvel inventariado</se:Name>
          <se:Description>
            <se:Title>150 - Imóvel inventariado</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>codigo</ogc:PropertyName>
              <ogc:Literal>150</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer FilledMarker not implemented yet-->
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:OnlineResource xlink:type="simple" xlink:href="ttf://Arial"/>
                <se:Format>ttf</se:Format>
                <se:MarkIndex>73</se:MarkIndex>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
              </se:Mark>
              <se:Size>8</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name></se:Name>
          <se:Description>
            <se:Title>"codigo" is ''</se:Title>
          </se:Description>
          <se:ElseFilter xmlns:se="http://www.opengis.net/se"/>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#000000</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>7</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:TextSymbolizer>
            <se:Label>
              <ogc:PropertyName>codigo</ogc:PropertyName>
            </se:Label>
            <se:Font>
              <se:SvgParameter name="font-family">Open Sans</se:SvgParameter>
              <se:SvgParameter name="font-size">13</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:AnchorPoint>
                  <se:AnchorPointX>0</se:AnchorPointX>
                  <se:AnchorPointY>0.5</se:AnchorPointY>
                </se:AnchorPoint>
              </se:PointPlacement>
            </se:LabelPlacement>
            <se:Halo>
              <se:Radius>2</se:Radius>
              <se:Fill>
                <se:SvgParameter name="fill">#fafafa</se:SvgParameter>
              </se:Fill>
            </se:Halo>
            <se:Fill>
              <se:SvgParameter name="fill">#ff0000</se:SvgParameter>
            </se:Fill>
            <se:VendorOption name="maxDisplacement">1</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
