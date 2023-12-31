PGDMP                  
    {            servicio    16.0    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16725    servicio    DATABASE     �   CREATE DATABASE servicio WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE servicio;
                postgres    false            �            1259    16743    llamadas    TABLE     �   CREATE TABLE public.llamadas (
    idllamada integer NOT NULL,
    empleadoid integer,
    fecha_hora timestamp without time zone NOT NULL,
    clienteid integer,
    descripcion text,
    idtipopregunta integer,
    ordenid integer
);
    DROP TABLE public.llamadas;
       public         heap    postgres    false            �            1259    16742    llamadas_idllamada_seq    SEQUENCE     �   CREATE SEQUENCE public.llamadas_idllamada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.llamadas_idllamada_seq;
       public          postgres    false    220                        0    0    llamadas_idllamada_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.llamadas_idllamada_seq OWNED BY public.llamadas.idllamada;
          public          postgres    false    219            �            1259    16727    ordenes    TABLE     �   CREATE TABLE public.ordenes (
    idorden integer NOT NULL,
    clienteid integer,
    fecha_hora timestamp without time zone NOT NULL,
    descripcion text
);
    DROP TABLE public.ordenes;
       public         heap    postgres    false            �            1259    16726    ordenes_idorden_seq    SEQUENCE     �   CREATE SEQUENCE public.ordenes_idorden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.ordenes_idorden_seq;
       public          postgres    false    216                       0    0    ordenes_idorden_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.ordenes_idorden_seq OWNED BY public.ordenes.idorden;
          public          postgres    false    215            �            1259    16736    tipospregunta    TABLE     r   CREATE TABLE public.tipospregunta (
    idtipollamada integer NOT NULL,
    descripcion character varying(255)
);
 !   DROP TABLE public.tipospregunta;
       public         heap    postgres    false            �            1259    16735    tipospregunta_idtipollamada_seq    SEQUENCE     �   CREATE SEQUENCE public.tipospregunta_idtipollamada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.tipospregunta_idtipollamada_seq;
       public          postgres    false    218                       0    0    tipospregunta_idtipollamada_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.tipospregunta_idtipollamada_seq OWNED BY public.tipospregunta.idtipollamada;
          public          postgres    false    217            \           2604    16746    llamadas idllamada    DEFAULT     x   ALTER TABLE ONLY public.llamadas ALTER COLUMN idllamada SET DEFAULT nextval('public.llamadas_idllamada_seq'::regclass);
 A   ALTER TABLE public.llamadas ALTER COLUMN idllamada DROP DEFAULT;
       public          postgres    false    220    219    220            Z           2604    16730    ordenes idorden    DEFAULT     r   ALTER TABLE ONLY public.ordenes ALTER COLUMN idorden SET DEFAULT nextval('public.ordenes_idorden_seq'::regclass);
 >   ALTER TABLE public.ordenes ALTER COLUMN idorden DROP DEFAULT;
       public          postgres    false    216    215    216            [           2604    16739    tipospregunta idtipollamada    DEFAULT     �   ALTER TABLE ONLY public.tipospregunta ALTER COLUMN idtipollamada SET DEFAULT nextval('public.tipospregunta_idtipollamada_seq'::regclass);
 J   ALTER TABLE public.tipospregunta ALTER COLUMN idtipollamada DROP DEFAULT;
       public          postgres    false    218    217    218            �          0    16743    llamadas 
   TABLE DATA           v   COPY public.llamadas (idllamada, empleadoid, fecha_hora, clienteid, descripcion, idtipopregunta, ordenid) FROM stdin;
    public          postgres    false    220   �       �          0    16727    ordenes 
   TABLE DATA           N   COPY public.ordenes (idorden, clienteid, fecha_hora, descripcion) FROM stdin;
    public          postgres    false    216   �       �          0    16736    tipospregunta 
   TABLE DATA           C   COPY public.tipospregunta (idtipollamada, descripcion) FROM stdin;
    public          postgres    false    218   �                  0    0    llamadas_idllamada_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.llamadas_idllamada_seq', 1, false);
          public          postgres    false    219                       0    0    ordenes_idorden_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.ordenes_idorden_seq', 1, false);
          public          postgres    false    215                       0    0    tipospregunta_idtipollamada_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipospregunta_idtipollamada_seq', 1, false);
          public          postgres    false    217            b           2606    16750    llamadas llamadas_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.llamadas
    ADD CONSTRAINT llamadas_pkey PRIMARY KEY (idllamada);
 @   ALTER TABLE ONLY public.llamadas DROP CONSTRAINT llamadas_pkey;
       public            postgres    false    220            ^           2606    16734    ordenes ordenes_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT ordenes_pkey PRIMARY KEY (idorden);
 >   ALTER TABLE ONLY public.ordenes DROP CONSTRAINT ordenes_pkey;
       public            postgres    false    216            `           2606    16741     tipospregunta tipospregunta_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipospregunta
    ADD CONSTRAINT tipospregunta_pkey PRIMARY KEY (idtipollamada);
 J   ALTER TABLE ONLY public.tipospregunta DROP CONSTRAINT tipospregunta_pkey;
       public            postgres    false    218            c           2606    16751 %   llamadas llamadas_idtipopregunta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.llamadas
    ADD CONSTRAINT llamadas_idtipopregunta_fkey FOREIGN KEY (idtipopregunta) REFERENCES public.tipospregunta(idtipollamada);
 O   ALTER TABLE ONLY public.llamadas DROP CONSTRAINT llamadas_idtipopregunta_fkey;
       public          postgres    false    218    220    4704            d           2606    16756    llamadas llamadas_ordenid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.llamadas
    ADD CONSTRAINT llamadas_ordenid_fkey FOREIGN KEY (ordenid) REFERENCES public.ordenes(idorden);
 H   ALTER TABLE ONLY public.llamadas DROP CONSTRAINT llamadas_ordenid_fkey;
       public          postgres    false    220    216    4702            �      x������ � �      �      x������ � �      �      x������ � �     