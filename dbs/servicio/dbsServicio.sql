PGDMP      1        
    
    {            servicio cliente 2    16.0    16.0 5    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    16492    servicio cliente 2    DATABASE     �   CREATE DATABASE "servicio cliente 2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 $   DROP DATABASE "servicio cliente 2";
                postgres    false            �            1259    16531    bodegas    TABLE     y   CREATE TABLE public.bodegas (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion text
);
    DROP TABLE public.bodegas;
       public         heap    postgres    false            �            1259    16530    bodegas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bodegas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.bodegas_id_seq;
       public          postgres    false    222            %           0    0    bodegas_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.bodegas_id_seq OWNED BY public.bodegas.id;
          public          postgres    false    221            �            1259    16494    clientes    TABLE     z   CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion text
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    16493    clientes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.clientes_id_seq;
       public          postgres    false    216            &           0    0    clientes_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;
          public          postgres    false    215            �            1259    16556    detalle_ordenes    TABLE     �   CREATE TABLE public.detalle_ordenes (
    id integer NOT NULL,
    orden_id integer,
    producto_id integer,
    cantidad integer
);
 #   DROP TABLE public.detalle_ordenes;
       public         heap    postgres    false            �            1259    16555    detalle_ordenes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_ordenes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.detalle_ordenes_id_seq;
       public          postgres    false    226            '           0    0    detalle_ordenes_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.detalle_ordenes_id_seq OWNED BY public.detalle_ordenes.id;
          public          postgres    false    225            �            1259    16517    llamadas    TABLE     �   CREATE TABLE public.llamadas (
    id integer NOT NULL,
    empleado_id integer,
    fecha_hora timestamp without time zone NOT NULL,
    cliente_id integer,
    descripcion text,
    tipo_pregunta character varying(255)
);
    DROP TABLE public.llamadas;
       public         heap    postgres    false            �            1259    16516    llamadas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.llamadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.llamadas_id_seq;
       public          postgres    false    220            (           0    0    llamadas_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.llamadas_id_seq OWNED BY public.llamadas.id;
          public          postgres    false    219            �            1259    16503    ordenes    TABLE     �   CREATE TABLE public.ordenes (
    id integer NOT NULL,
    cliente_id integer,
    fecha_hora timestamp without time zone NOT NULL,
    descripcion text
);
    DROP TABLE public.ordenes;
       public         heap    postgres    false            �            1259    16502    ordenes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ordenes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.ordenes_id_seq;
       public          postgres    false    218            )           0    0    ordenes_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.ordenes_id_seq OWNED BY public.ordenes.id;
          public          postgres    false    217            �            1259    16542 	   productos    TABLE     ~   CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    bodega_id integer
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    16541    productos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.productos_id_seq;
       public          postgres    false    224            *           0    0    productos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;
          public          postgres    false    223            l           2604    16534 
   bodegas id    DEFAULT     h   ALTER TABLE ONLY public.bodegas ALTER COLUMN id SET DEFAULT nextval('public.bodegas_id_seq'::regclass);
 9   ALTER TABLE public.bodegas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            i           2604    16497    clientes id    DEFAULT     j   ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);
 :   ALTER TABLE public.clientes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            n           2604    16559    detalle_ordenes id    DEFAULT     x   ALTER TABLE ONLY public.detalle_ordenes ALTER COLUMN id SET DEFAULT nextval('public.detalle_ordenes_id_seq'::regclass);
 A   ALTER TABLE public.detalle_ordenes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            k           2604    16520    llamadas id    DEFAULT     j   ALTER TABLE ONLY public.llamadas ALTER COLUMN id SET DEFAULT nextval('public.llamadas_id_seq'::regclass);
 :   ALTER TABLE public.llamadas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            j           2604    16506 
   ordenes id    DEFAULT     h   ALTER TABLE ONLY public.ordenes ALTER COLUMN id SET DEFAULT nextval('public.ordenes_id_seq'::regclass);
 9   ALTER TABLE public.ordenes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            m           2604    16545    productos id    DEFAULT     l   ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);
 ;   ALTER TABLE public.productos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224                      0    16531    bodegas 
   TABLE DATA           8   COPY public.bodegas (id, nombre, direccion) FROM stdin;
    public          postgres    false    222   �:                 0    16494    clientes 
   TABLE DATA           9   COPY public.clientes (id, nombre, direccion) FROM stdin;
    public          postgres    false    216   �:                 0    16556    detalle_ordenes 
   TABLE DATA           N   COPY public.detalle_ordenes (id, orden_id, producto_id, cantidad) FROM stdin;
    public          postgres    false    226   ;                 0    16517    llamadas 
   TABLE DATA           g   COPY public.llamadas (id, empleado_id, fecha_hora, cliente_id, descripcion, tipo_pregunta) FROM stdin;
    public          postgres    false    220   3;                 0    16503    ordenes 
   TABLE DATA           J   COPY public.ordenes (id, cliente_id, fecha_hora, descripcion) FROM stdin;
    public          postgres    false    218   P;                 0    16542 	   productos 
   TABLE DATA           :   COPY public.productos (id, nombre, bodega_id) FROM stdin;
    public          postgres    false    224   m;       +           0    0    bodegas_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.bodegas_id_seq', 1, false);
          public          postgres    false    221            ,           0    0    clientes_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.clientes_id_seq', 1, false);
          public          postgres    false    215            -           0    0    detalle_ordenes_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.detalle_ordenes_id_seq', 1, false);
          public          postgres    false    225            .           0    0    llamadas_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.llamadas_id_seq', 1, false);
          public          postgres    false    219            /           0    0    ordenes_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ordenes_id_seq', 1, false);
          public          postgres    false    217            0           0    0    productos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.productos_id_seq', 1, false);
          public          postgres    false    223            v           2606    16540    bodegas bodegas_nombre_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT bodegas_nombre_key UNIQUE (nombre);
 D   ALTER TABLE ONLY public.bodegas DROP CONSTRAINT bodegas_nombre_key;
       public            postgres    false    222            x           2606    16538    bodegas bodegas_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT bodegas_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.bodegas DROP CONSTRAINT bodegas_pkey;
       public            postgres    false    222            p           2606    16501    clientes clientes_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    216            ~           2606    16561 $   detalle_ordenes detalle_ordenes_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.detalle_ordenes
    ADD CONSTRAINT detalle_ordenes_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.detalle_ordenes DROP CONSTRAINT detalle_ordenes_pkey;
       public            postgres    false    226            t           2606    16524    llamadas llamadas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.llamadas
    ADD CONSTRAINT llamadas_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.llamadas DROP CONSTRAINT llamadas_pkey;
       public            postgres    false    220            r           2606    16510    ordenes ordenes_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT ordenes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.ordenes DROP CONSTRAINT ordenes_pkey;
       public            postgres    false    218            z           2606    16549    productos productos_nombre_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nombre_key UNIQUE (nombre);
 H   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_nombre_key;
       public            postgres    false    224            |           2606    16547    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    224            �           2606    16562 -   detalle_ordenes detalle_ordenes_orden_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_ordenes
    ADD CONSTRAINT detalle_ordenes_orden_id_fkey FOREIGN KEY (orden_id) REFERENCES public.ordenes(id);
 W   ALTER TABLE ONLY public.detalle_ordenes DROP CONSTRAINT detalle_ordenes_orden_id_fkey;
       public          postgres    false    4722    226    218            �           2606    16567 0   detalle_ordenes detalle_ordenes_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_ordenes
    ADD CONSTRAINT detalle_ordenes_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);
 Z   ALTER TABLE ONLY public.detalle_ordenes DROP CONSTRAINT detalle_ordenes_producto_id_fkey;
       public          postgres    false    224    226    4732            �           2606    16525 !   llamadas llamadas_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.llamadas
    ADD CONSTRAINT llamadas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);
 K   ALTER TABLE ONLY public.llamadas DROP CONSTRAINT llamadas_cliente_id_fkey;
       public          postgres    false    216    220    4720                       2606    16511    ordenes ordenes_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT ordenes_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);
 I   ALTER TABLE ONLY public.ordenes DROP CONSTRAINT ordenes_cliente_id_fkey;
       public          postgres    false    216    4720    218            �           2606    16550 "   productos productos_bodega_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_bodega_id_fkey FOREIGN KEY (bodega_id) REFERENCES public.bodegas(id);
 L   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_bodega_id_fkey;
       public          postgres    false    222    4728    224                  x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �     