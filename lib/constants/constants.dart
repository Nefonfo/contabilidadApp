final List<Map<String, String>> types = [
  {
    "name": "DOCUMENTOS POR PAGAR",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "IMPUESTOS POR PAGAR",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "ACREEDORES DIVERSOS",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "CREDITOS BANCARIOS",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "ANTICIPO A CLIENTES",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "PROVEEDORES",
    "type": "PASIVO",
    "subType": "CORTO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "ACREEDORES DIVERSOS A LARGO PLAZO",
    "type": "PASIVO",
    "subType": "LARGO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "CREDITOS BANCARIOS A LARGO PLAZO",
    "type": "PASIVO",
    "subType": "LARGO PLAZO",
    "natural": "ACREEDOR"
  },
  {
    "name": "CAJA",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "BANCOS",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "DEUDORES DIVERSOS",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "PAGOS ANTICIPADOS",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "ANTICIPO A PROVEEDORES",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "DOCUMENTOS POR COBRAR",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "CLIENTES",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "ALMACEN",
    "type": "ACTIVO",
    "subType": "CIRCULANTE",
    "natural": "DEUDOR"
  },
  {
    "name": "INVERSIONES TEMPORALES",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "EDIFICIOS",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "MOBILIARIO",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "EQUIPO DE TRANSPORTE",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "EQUIPO DE COMPUTO",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "MAQUINARIA Y EQUIPO",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "TERRENOS",
    "type": "ACTIVO",
    "subType": "FIJO",
    "natural": "DEUDOR"
  },
  {
    "name": "CREDITO MERCANTIL",
    "type": "ACTIVO",
    "subType": "DIFERIDO",
    "natural": "DEUDOR"
  },
  {
    "name": "PATENTES Y MARCAS",
    "type": "ACTIVO",
    "subType": "DIFERIDO",
    "natural": "DEUDOR"
  },
  {
    "name": "GASTOS DE ORGANIZACION",
    "type": "ACTIVO",
    "subType": "DIFERIDO",
    "natural": "DEUDOR"
  },
  {
    "name": "GASTOS PREOPERATIVOS",
    "type": "ACTIVO",
    "subType": "DIFERIDO",
    "natural": "DEUDOR"
  },
  {
    "name": "GASTOS DE INVESTIGACION",
    "type": "ACTIVO",
    "subType": "DIFERIDO",
    "natural": "DEUDOR"
  },
  {
    "name": "VENTAS TOTALES",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "ACREEDOR"
  },
  {
    "name": "DEVOLUCIONES / VENTAS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "INVENTARIO INICIAL",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "ACREEDOR"
  },
  {
    "name": "INVENTARIO FINAL",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "COMPRAS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "ACREEDOR"
  },
  {
    "name": "DEVOLUCIONES / COMPRAS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "GASTOS DE ADMINISTRACION",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "GASTOS DE VENTAS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "PRODUCTOS FINANCIEROS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "ACREEDOR"
  },
  {
    "name": "GASTOS FINANCIEROS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "OTROS INGRESOS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "ACREEDOR"
  },
  {
    "name": "OTROS GASTOS",
    "type": "RESULTADO",
    "subType": "RESULTADO",
    "natural": "DEUDOR"
  },
  {
    "name": "RESERVA LEGAL",
    "type": "CAPITAL",
    "subType": "CAPITAL",
    "natural": "ACREEDOR"
  },
  {
    "name": "CAPITAL SOCIAL",
    "type": "CAPITAL",
    "subType": "CAPITAL",
    "natural": "ACREEDOR"
  },
  {
    "name": "UTILIDADES ACUMULADAS",
    "type": "CAPITAL",
    "subType": "CAPITAL",
    "natural": "ACREEDOR "
  }
];
