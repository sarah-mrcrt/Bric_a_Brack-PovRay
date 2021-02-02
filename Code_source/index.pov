/** @file index.pov
* Travaux pratiques d’infographie : Atelier de bricolage
* @author Téo L'Huillier & Sarah Mauriaucourt
* @date 29/12/2020 - 29/01/2021
*
* Structuration des scripts
*/
               
               
//********************************* Réglages *******************************
#version 3.7;  
global_settings
{
assumed_gamma 2.0 
}
#default{ finish { ambient 0.1 diffuse 0.9 conserve_energy } }  

//********************************* Directives ****************************
#include "colors.inc"
#include "transforms.inc"  
#include "textures.inc"
#include "shapes.inc"   
#include "woods.inc"    
#include "glass.inc"  
#include "stars.inc"
#include "./Ressources/blender/blender.pov"

//********************************* Variables communes ********************
#declare epsilon = 1e-3;
 
//********************************* Scène *********************************  
//********************************* Environnement technique 
// Caméra //
camera  
{ 
    perspective
    right x * image_width/image_height
    up y 
    location  <180,90,58>
    look_at <20,110,85> // Vu de côté   
    focal_point <25,80,4> 
    aperture 1.4 // Ouverture
    blur_samples 100 // Nombre de rayons par pixel pour l'échantillonnage
    // confidence 0.95 // Simule la profondeur de champ focale
    variance 1/200 // Degré de précision du calcul lors du rendu (plus il est petit, plus il est précis)      
 }   

// Lumières //
// Lumière de type soleil   
light_source { <2000,1000,  0> White*0.3  fade_distance 0.75 }
// Lumière de type spotlight 
light_source
{
    <300,60, -800>  // Position de la lumière 
    Orange*1.3 // Couleur de la source
    spotlight // Projecteur de type spogtligh
    radius 5 // Rayon du cercle intérieur de la lumière qui est totalement éclairée 
    falloff 10 // Rayon du cercle extérieur oû la lumière va être atténuée
    tightness 10 // Joue sur le degradé/atténuation de la lumière 
    point_at <2,60,70> // Position qu'on veut éclairer
}

//********************************* Conception de la scène
//**** 1 - Modelisation (formes, materiaux) // 
/* Forme géométrique */
#declare Etoile = sphere{ <0,0,0>, 1 }    
// Décoration //
// Mur
#declare MurGauche = box { <0,0,0> <400,320,2> } 
#declare MurDroit = box { <0,0,0> <2,320,400> }   
#declare MurFenetre = box{ <0,0,-.2>, < 125,75.5,2.2> }
// Fenêtre                                         
#declare Vanteau = box{ <0,0,-.5>, <55,65.5,2.5> } 
// Etagère
#declare Planche = box { <2,0,2> <50,3,400> }
// Panneau de rangement
#declare Panneau = box { <2,0,2> <3.5,80,200> } // Diametre = 15 mm   
// Miroir 
#declare Cadre =  box { <0, 0, 0>, <2, 10, 10> }
#declare PlaqueVerre = box { <1, 1, 1.5>, <2.5,9,9> }
// Horloge  
#declare HorlogeContourTorus = torus { 4.4,1 }  
#declare HorlogeContourSphere = cylinder { <0,0,0>,<0,1,0>, 4.5 } 
#declare HorlogeVerre = sphere { <0,0,0>, 4.91 }
#declare HorlogeSocle = cylinder { <0,0,0>,<0,.15,0>, 4.4 }  
#declare HorlogeVerre = sphere { <0,0,0>, 4.91 }  
#declare UnionAiguilles = cylinder { <0,0,0>,<0,.5,0>, .25 }  
#declare GrandeAiguille = cylinder { <0,0,0>,<0,.2,2.5>, .13 } 
#declare PetiteAiguille = cylinder { <0,0,0>,<1.5,.2,0>, .1 } 
#macro Heure(Text) union { text { ttf "crystal.ttf" Text 0.15 0 } } #end   
#declare TroisHeure = Heure("3") 
#declare SixHeure = Heure("6") 
#declare NeufHeure = Heure("9") 
#declare DouzeHeure = Heure("12")  
// Feuilles   
#macro Feuille(LargeurDebut,LongeurDebut,HauteurDebut,LargeurFin,LongeurFin,HauteurFin) 
union 
{ 
    box { <LargeurDebut,LongeurDebut,HauteurDebut> <LargeurFin,LongeurFin,HauteurFin> translate <-0.5, -0.5, -0.5> } 
} 
#end           
#declare Feuilles = Feuille(0,0,0,21,29.7,30) // 1 feuille a une épaisseur de .1cm 
// Livre
#declare PremiereDeCouverture = box { <0,0,0>,<15, 18, .5> }    
#declare QuatriemeDeCouverture = box { <0,0,3.15>,<15, 18, 3.65> } 
#declare Tranche = cylinder { <0,0,1>,<0,18,1>, 1 } 
#declare Pages = Feuille(2,.5,.5,14,17.5,3.15)   
// Cendrier 
#declare Cone = cone { < 0, 0, 0 >, 5, < 0, 2, 0 >, 4 }
#declare Sphere = sphere { < 0, 4, 0 >, 3.5 }
#declare Cylinder = cylinder { < -6, 2, 0 >, < 6, 2, 0 >, 0.5 }
// Cigarette 
#declare FeuilleRouler = cylinder{ <0,0,0>,<0,8,0>,.4 }
#declare Filtre = cylinder{ <0,0.01,0>,<0,2,0>,.4 }
#declare Nicotine = cylinder{ <0,0.5,0>,<0,9,0>,.3 }
#declare FumeeTabac = sphere { 0,3 hollow on } // "Hollow on" permet de rendre creux l'objet 
// Multiprise  
#declare Prise = cylinder { <0,4,0>,<0,5.5,0>, 2 }
#declare SupportPrise = Round_Box(<0,0,0>,<15.5,5,5>, 0.5 , 0 )
#declare PriseTypeE = cylinder { <0,3.5,0>,<0,4.5,0>, .25 } 
// Rangement tournevis
#declare SupportRangementTournevis = box { <0,0,0>, <5,5,16> }      
#declare TrouSupportRangementTournevis = box { <1,-.5,-.5>, <5.5,4,16.5> } 
#declare TrouRangementTournevis = cylinder { <0,-10,0>,<0,20,0>, .3 }
 
// Quincaillerie  // 
// Clou
#declare TeteClou = cylinder { <0,0,0>,<0,.2,0>, 1 } 
#declare CorpsClou = cylinder { <0,0,0>, <0,4.5,0>, .4 }          
#declare PointeClou = cone { <0,4.5,0>, .4, <0,5.5,0>, 0 }
// Vis        
// Ecrou
#declare EcrouHexagone = prism { linear_sweep linear_spline 0, 1, 7, <3,5>, <-3,5>, <-5,0>, <-3,-5>, <3, -5>, <5,0>, <3,5> } 
#declare EcrouTrou = sphere { <0,0,0> 1 }
// Rondelle    
#declare RondellePlate = disc
{ 
    <0,0,0>, // <x,y,z> du centre du disque 
    <0,1,0>, // vecteur normal au disque 
    1.0, // Rayon extérieur 
    0.5 // Rayon intérieur
} 
// Câble/Fil
#declare Fil = sphere_sweep
{
    cubic_spline
    22,
    <0, .2, 2>, .2
    <0, 1, 2>, .2
    <0, 5, 1.9>, .2
    <5, 13, 1.8>, .2
    <12.2, 9.1, 1.7> .2 
    <9.7, 1.8, 1.6> .2
    <2.2, 2.9, 1.5> .2
    <1.7, 10.2, 1.4> .2
    <9, 12.4, 1.3> .2
    <12.2, 6.1, 1.2> .2
    <7, 1.5, 1.1> .2 
    <1.1, 6.8, 1.1> .2
    <4.5, 13.3, 1.2> .2
    <11.2, 11.6, 1.3> .2
    <12.8, 4.8, 1.4> .2
    <6.8, 0.3, 1.5> .2
    <0.2, 4.7, 1.6> .2
    <2.5, 12.7, 1.7> .2
    <9, 13.6, 1.8> .2
    <13.2, 9.3, 1.9> .2 
    <13.5, 1.2, 2> .2
    <13.5, .2, 2> .2
 } 
 
// Outils //
// Tête : Marteau      
#declare TeteMarteau = prism 
{
    bezier_spline
    linear_sweep
    0, 2, 4*13, 
    <0,.4>, <0,.24>, <.13,0>, <.32,0>,
    <.32,0>, <2,0>, <3.65,0>,<4,0>,
    <4,0>, <4,0>, <6.87,.28>, <6.87,.28>,
    <6.87,.28>, <6.94,.28>, <7,.37>, <7,.43>                                                           
    <7,.43>, <7,.43>, <7,.66>, <7,.66>,
    <7,.66>, <7,.72>, <6.95,.8>, <6.87,.8>,
    <6.87,.8>, <6.3,.9>, <5.55,1.01>, <5.3,1.04>,
    <5.3,1.04>, <5.17,1.06>, <4.9,1.17>, <4.78,1.3>,
    <4.78,1.3>, <4.78,1.3>, <4.1,1.9>, <4.1,1.9>,
    <4.1,1.9>, <4.06,1.94>, <3.94,2>, <3.85,2>,
    <3.85,2>, <3.85,2>, <.3,2>, <.3,2>, 
    <.3,2>, <.19,1.99>, <.02,1.87>, <0,1.7> 
    <0,1.7>, <0,1.7>, <0,.4>, <0,.4>
}
// Manche : Marteau
#declare MancheMarteau = cylinder{ <0,0,0>,<0,10,0>, 1 }
// Fourche : Clé plate
#declare ClePlateFourcheCylindre = cylinder{ <0,0,0>,<0,.31,0>, 1.25 } 
#declare ClePlateFourcheBox = Round_Box(<-3,-1,-.5>,<0,1,.5>, 0.125, 0) // Création d'une box avec des contours arrondies : Round_Box(A, B, WireRadius, Merge)        
// Manche : Clé plate 
#declare ClePlateManche = box { <0,0,-.55>, < 8.5,0.3,.55> }
// Burin
#declare Burin = prism 
{
    bezier_spline
    linear_sweep 
    0, 2, 4*15,
    <0,.1>, <0,.04>, <.06,0>, <.1,0>,
    <.1,0>, <.1,0>, <.55,0>,<.55,0>,  
    <.55,0>, <.58,0>, <.6,.03>, <.6,.05>,
    <.6,.05>, <.6,.1>, <.62, .1>, <.65,.1>,
    <.65,.1>, <.65,.1>, <13,.1>, <13,.1>,
    <13,.1>, <13,.1>, <14.9,.4>, <14.9,.4>,  
    <14.9,.4>, <14.96,.41>, <15,.47>, <15,.5>,
    <15,.5>, <15,.54>, <14.96,.6>, <14.9,.6>,
    <14.9,.6>, <14.9,.6>, <13,.9>, <13,.9>,
    <13,.9>, <13,.9>, <.65,.9>, <.65,.9>,
    <.65,.9>, <.62,.9>, <.6,.94>, <.6,.96>,
    <.6,.96>, <.6,.98>, <.58,1>, <.55,1>,
    <.55,1>, <.55,1>, <.1,1>, <.1,1>,
    <.1,1>, <.06,1>, <0,.96>, <0,.9>,   
    <0,.9>, <0,.9>, <0,.1>, <0,.1> 
} 
// Manche : Tournevis    
#declare TournevisManche = lathe
{
    bezier_spline
    4*6,
    <0,0>, <.36,0>, <.75,.17>, <.85,.29>,
    <.85,.29>, <1.17,1.18>, <1.33, 3.46>, <.85,4.89>,
    <.85,4.89>, <.7,5.83>, <.91,6.78>, <1.11,7>,
    <1.11,7>, <1.11,7>, <1.11,7.29>, <1.11,7.29>,
    <1.11,7.29>, <.85,7.25>, <.63,7.39>, <.6,7.5>,
    <.6,7.5>, <.6,7.5>, <.2,7.5>,<.2,7.5>
}  
// Tête : Tournevis
#declare TournevisCorps = cylinder{ <0,0,0>,<0,11.4,0>, .25 }
#declare TournevisEmbout = prism { linear_spline linear_sweep 0, .5, 8 <.2,0>, <.3,.8>, <.3,1>, <.2,1.6>, <-.2,1.6>, <-.3,1>,  <-.3,.8>, <-.2,0> } // Ligne 
 
/* Matériaux */
// Ciel étoilée
#declare CielNocturne = material { texture { Starfield1 scale 0.25 } scale 20000 } // Source : http://www.f-lohmueller.de/pov_tut/backgrnd/p_sky7f.htm               
// Brique
#declare Brique = material 
{ 
    texture 
    { 
        pigment { brick color White color Brown*.5 brick_size <10,10,20> } // Motif de brique qui prend en paramètre deux couleurs et la taille des briques  
        finish { ambient 0.2 diffuse 0.9 phong 0.2 } // Reflet sur les briques grâce à la gestion de la lumière 
        normal { wrinkles 0.75 scale 0.01 } // Relief des briques : Effet de grain qui on une échelle de .01 cm
    }  
}  
// Bois   
#declare Bois = material 
{ 
    texture 
    { 
        pigment { DarkBrown*0.95 } // Couleur marron légérement désaturée  
        normal { bumps 0.50 scale 0.10} // Surface lègèrement bossée 
    } 
} 
#declare Liege = material 
{
    texture
    {
        pigment {  
            wood turbulence 0.2 rotate <-80,-20,0> scale <1,8,1>*0.07 //  ; Echelle des pigments donnent l'effet de grain 
            color_map { [ 0 rgb <149,115,45>/255*1.1 ] [ 1 rgb <149,115,45>/255*0.6 ] } // Couleur du pigment "wood" : 2 couleurs marrons claires pour l'effet de liège
        }        
        finish{ ambient 1 diffuse 0.6 specular 0.4 roughness 0.01 }
    }  
} 
#declare Chene = material 
{
    texture{
        pigment { image_map { jpeg "./Ressources/img/chene.jpg" } }
  
        finish { reflection { 0, 0.7 fresnel on } ambient .3 diffuse 1 } // Reflet : Effet de vernis
        rotate x*60 // Inclainaison de la texture
        scale <1/2,1,1>*40 // Echelle de la texture
    }
    interior { ior 1.03 }
}
#declare Frene = material { texture { T_Wood5 }  }
// Transparent   
#declare VerreMinerale = material { texture { T_Glass3 }  }
#declare VerreAcrylique = material { texture { pigment { color rgbt <1,1,1,0.7> } finish { phong 1.0 reflection epsilon } } }  
#declare VerreReflexion = material { texture { Polished_Brass finish { ambient .1} } }
#declare MonoxydeDeCarbone = material 
{ 
    texture { pigment { rgbt 1 } }
    interior
    { 
        media
        { 
            absorption 5 // Opacité de la fumée
            density 
            {  
                spherical density_map 
                { 
                    [0 rgb 0] [0.5 rgb 0] [0.7 rgb .5] [1 rgb 1] // Nuance de gris 
                } 
                scale 1/2 warp { turbulence 0.5 } scale 2  // Bruit dans le motif
            } 
         }
     }
     scale <1.5,6,1.5> translate y
}
#declare BlancTransparent = material { texture { pigment{ color White } finish { ambient 0.9 phong 0.5} } } 
#declare OrangeTransparent = material { texture { pigment { color rgb <1,.5,0> filter .4 } } }  
#declare RougeTransparent = material { texture { pigment { color Red transmit .6 } finish { ambient .1 phong .6} } interior { ior 1.4 } }
// Métal                                                                           
#declare Metal = material { texture { Chrome_Metal finish { ambient 0.3 diffuse 0.7 brilliance 8 specular 0.8 roughness 0.1 reflection 0.15 phong 1 } } }  
#declare RouilleFer = material { texture { Rust } } 
#declare Aluminium = material { texture { Brushed_Aluminum } }
// Couleurs
#declare BlancNeige = material { texture { pigment { color White*1.1 } finish { ambient 1} } }     
#declare BlancMatte = material { texture { pigment { color White*.7 } } } 
#declare Orange = material { texture { pigment { color Orange } } } 
#declare TextureDark  = material { texture { pigment{ color rgb<0,0,0> } finish { phong 1 } } }
#declare TextureLight = material { texture { pigment{ color rgb<1,1,1> } finish { phong 1 } } } 
#macro EmpilementFeuilles(Axe)  
material 
{ 
    texture 
    {
         pigment {
            gradient Axe // Sur quel axe est placé le grandient du "color_map"
            color_map // Nuances de gris 
            { 
               [ 0.0 colour White ]
               [ 0.1 colour Gray90 ]
               [ 0.2 colour White ]
               [ 0.3 colour Gray95 ]
               [ 0.4 colour White ]
               [ 0.5 colour Gray80 ]
               [ 0.6 colour White ]
               [ 0.6 colour Gray95 ]
               [ 0.8 colour White ]
               [ 0.9 colour Gray90 ]
               [ 1.0 colour Gray85 ]
            } 
          } 
          finish { ambient 0.6 diffuse 0.7 } 
          scale <0, -3, 0> // Echelle
    } 
} 
#end
#declare EmpilementFeuillesY = EmpilementFeuilles(y) // Grandient sur l'axe des y 
#declare EmpilementFeuillesX = EmpilementFeuilles(z) // Grandient sur l'axe des y



//**** 2 - Habillage (On met les textures sur les formes et matériaux créés) //
// Scène //
#declare Etoile_CielNocturne = object { Etoile material { CielNocturne } } 
// Décoration //
// Mur 
#declare MurGauche_Brique = object { MurGauche material { Brique } } 
#declare MurDroit_Brique = object { MurDroit material { Brique } }
#declare MurFenetre_White = object { MurFenetre material { BlancNeige } } 
// Fênetre
#declare Vanteau_Verre = object { Vanteau material { VerreMinerale } }
// Table     
// Etagère
#declare Etagere_Bois = object { Planche material { Bois } }     
// Panneau
#declare Panneau_Liege = object { Panneau material { Liege } }   
// Miroir
#declare Cadre_Frene = object { Cadre material { Frene } }
#declare PlaqueVerre_VerreReflexion = object { PlaqueVerre material { VerreReflexion } } 
// Feuilles
#declare Feuilles_EmpilementFeuillesY = object { Feuilles material { EmpilementFeuillesY } }
// Livres 
#declare PremiereDeCouverture_TextureDark = object { PremiereDeCouverture material { TextureDark } }
#declare QuatriemeDeCouverture_TextureDark = object { QuatriemeDeCouverture material { TextureDark } }
#declare Tranche_TextureDark = object { Tranche material { TextureDark } }
#declare Pages_EmpilementFeuillesX = object { Pages material { EmpilementFeuillesX } }
// Horloge 
#declare HorlogeContourTorus_Aluminium = object { HorlogeContourTorus material { Aluminium } } 
#declare HorlogeContourSphere_Aluminium = object { HorlogeContourSphere material { Aluminium } } 
#declare HorlogeVerre_VerreAcrylique = object { HorlogeVerre material { VerreAcrylique } } 
#declare HorlogeSocle_Aluminium  = object { HorlogeSocle material { Aluminium } }                                                                     
#declare TroisHeure_TextureDark = object { TroisHeure material { TextureDark } }
#declare SixHeure_TextureDark = object { SixHeure material { TextureDark } }
#declare NeufHeure_TextureDark = object { NeufHeure material { TextureDark } }
#declare DouzeHeure_TextureDark = object { DouzeHeure material { TextureDark } }
#declare UnionAiguilles_Gris = object { UnionAiguilles material { VerreReflexion } }    
#declare GrandeAiguille_Gris = object { GrandeAiguille material { VerreReflexion } }
#declare PetiteAiguille_Gris = object { PetiteAiguille material { VerreReflexion } }    
// Cendrier
#declare Cone_RougeTransparent = object { Cone material { RougeTransparent } }
#declare Cylinder_RougeTransparent = object { Cylinder material { RougeTransparent } }
#declare Sphere_RougeTransparent = object { Sphere material { RougeTransparent } }
// Cigarette
#declare FeuilleRouler_Blanc = object { FeuilleRouler material { BlancNeige } }  
#declare Nicotine_Marron = object { Nicotine material { BlancNeige } }
#declare Filtre_Orange = object { Filtre material { Orange } }
// Fumée cigarette  
#declare FumeeTabac_MonoxydeDeCarbone = object { FumeeTabac material { MonoxydeDeCarbone } }  
// Multiprise   
#declare Prise_BlancMatte = object { Prise material { BlancMatte } } 
#declare SupportPrise_Aluminium = object { SupportPrise material { Aluminium } } 
#declare PriseTypeE_TextureDark = object { PriseTypeE material { TextureDark } } 
// Fil
#declare Fil_TextureDark = object { Fil material { TextureDark } }
// Rangement tournevis 
#declare SupportRangementTournevis_Aluminium = object { SupportRangementTournevis material { Aluminium } }     
#declare TrouSupportRangementTournevis_Aluminium = object { TrouSupportRangementTournevis material { Aluminium } } 
#declare TrouRangementTournevis_Aluminium = object { TrouRangementTournevis material { Aluminium } }
 
// Quincaillerie //
// Clou
#declare TeteClou_RouilleFer = object { TeteClou material { RouilleFer } } 
#declare CorpsClou_RouilleFer = object { CorpsClou material { RouilleFer } }          
#declare PointeClou_RouilleFer = object { PointeClou material { RouilleFer } }
#declare TeteClou_Metal = object { TeteClou material { Metal } } 
#declare CorpsClou_Metal = object { CorpsClou material { Metal } }          
#declare PointeClou_Metal = object { PointeClou material { Metal } }  
// Rondelle plate
#declare RondellePlate_Metal = object { RondellePlate material { Metal } }
// Ecrou
#declare EcrouHexagone_Metal = object { EcrouHexagone material { Metal } }
#declare EcrouHexagone = object { EcrouHexagone material { Metal } }

// Outils //
// Marteau            
#declare TeteMarteau_Metal = object { TeteMarteau material { Metal } }
#declare MancheMarteau_Frene = object { MancheMarteau material { Frene } }
// Clé plate
#declare ClePlateFourcheCylindre_Metal =  object { ClePlateFourcheCylindre material { Metal } }   
#declare ClePlateFourcheBox_Metal =  object { ClePlateFourcheBox material { Metal } }
#declare ClePlateManche_Metal =  object { ClePlateManche material { Metal } } 
// Burin 
#declare Burin =  object { Burin material { Metal } }  
// Tournevis 
#declare TournevisCorps_Metal =  object { TournevisCorps material { Metal } } 
#declare TournevisEmbout_Metal =  object { TournevisEmbout material { Metal } }
#declare TournevisManche_OrangeTransparent =  object { TournevisManche material { OrangeTransparent } }
 
     
//**** 3 - Assemblage //   
// Décoration //
// Mur
#declare Mur = union
{ 
    object { MurDroit_Brique } 
    difference { object { MurGauche_Brique } object { MurFenetre  translate <50,100,0> } }   
}  
// Fenetre
# declare Fenetre = union
{    
    difference { object { MurFenetre_White } object { Vanteau_Verre translate <5,5,0> } object { Vanteau_Verre translate <65,5,0> } } 
    object { Vanteau_Verre translate <5,5,0> }    
    object { Vanteau_Verre translate <65,5,0> } 
    translate <50,100,0>   
}    
// Etagère
#declare Etagere = union { object { Etagere_Bois } translate <0,170,4> }  
// Panneau
#declare Panneau = union { object { Panneau_Liege }  translate <0,85,7> } 
// Miroir
#declare Miroir = union { difference { object { Cadre_Frene } object { PlaqueVerre_VerreReflexion } scale 5 } object { PlaqueVerre_VerreReflexion } translate <2,105,217> }
// Horloge
#declare Horloge = union
{   
    union 
    {    
        difference { object { HorlogeContourTorus_Aluminium  } object { HorlogeContourSphere_Aluminium } }    
        object { HorlogeVerre_VerreAcrylique scale <-1,.35,1> }   
        object { HorlogeSocle_Aluminium }       
        object { UnionAiguilles_Gris }
        union { object { PetiteAiguille_Gris } object { GrandeAiguille_Gris  } translate y*.3 }
        rotate x*-90 translate x*.15
    }
    object { TroisHeure_TextureDark translate <3.5,0,-.2> }
    object { SixHeure_TextureDark translate <-.3,-3.5,-.2> }
    object { NeufHeure_TextureDark translate <-3.5,0,-.2> }
    object { DouzeHeure_TextureDark translate <-.4,2.8,-.2> }                                                          
    translate <55,45,-2.5> scale 3  rotate y*-90
}
// Feuilles
#declare RamePapier = union { object { Feuilles_EmpilementFeuillesY } translate <0,173.3,100> }
// Livres
#declare Livres = union 
{   
    // On assemble un livre
    #declare Livre = union
    {  
        object { PremiereDeCouverture } 
        object { QuatriemeDeCouverture } 
        object { Tranche scale < 0, 0, 1.83>  }   
        object { Pages_EmpilementFeuillesX }
    } 
    // Création de variables aléatoires
    #declare Rnd_1 = seed (1153); 
    #declare Rnd_2 = seed (132);
    // Initialisation des variables pour la position dans l'espace des livres
    #declare InitialisationTranslate = -5;     
    #declare FinTranslate = 80; 
    // Création d'une boucle pour créer plusieurs livres et gérer leur localisation dans la scène  
    #while (InitialisationTranslate < FinTranslate+1)
        // Initialisation des variables pour la couleur des différents livres 
        #declare InitialisationCouleur = 0;    
        #declare FinCouleur =  4;  
        // Création d'une boucle pour avoir des couleurs aléatoires pour chaque livre créait 
        #while (InitialisationCouleur < FinCouleur+1) 
            object
            { 
                Livre translate <rand(Rnd_1), 0, rand(Rnd_1)+InitialisationTranslate>  
                texture { pigment{ color rgb < rand(Rnd_2), rand(Rnd_2), 1*rand(Rnd_2)> } finish { phong 1 } } 
            }
            #declare InitialisationCouleur = InitialisationCouleur+1;
        #end
        #declare InitialisationTranslate = InitialisationTranslate+5; // Pas : Espace entre chaque livre (en z) 
    #end  
    translate <-45,174,-220> rotate y*180      
}   
        
// Cendrier
#declare Cendrier = difference {
    object { Cone_RougeTransparent }
    object { Sphere_RougeTransparent }
    object { Cylinder_RougeTransparent }
    object { Cylinder_RougeTransparent rotate 90*y }   
    translate <60,78,50>
} 
// Cigarette
#declare Cigarette = union 
{ 
    difference {  object { FeuilleRouler_Blanc } object { Nicotine_Marron } } object { Filtre_Orange }
    object { FumeeTabac_MonoxydeDeCarbone translate <15,6,1> } 
    translate <40,78,60> rotate 40 
}
// Multiprise
#declare MultipriseMurale = union 
{ 
    difference 
    {
        object { SupportPrise_Aluminium } 
        union
        {  
            #for (Identifiant, 0, 10, 4.5 ) // #for(Identifier, Start, End [, Step])           
                object{ Prise_BlancMatte translate<2.8+Identifiant,0,2.5> }  
                union
                {
                    object { PriseTypeE_TextureDark translate <1.5+Identifiant,0,2.5> }
                    object { PriseTypeE_TextureDark translate <3.5+Identifiant,0,2.5> } 
                    object { PriseTypeE_TextureDark translate <2.5+Identifiant,0,3.5> }
               } 
            #end 
         }
     }  
     translate<15,1,-90> scale<1,1,1>*1.3 rotate<90,0,0>
}   
// Rangement tournevis   
#declare RangementTournevis = difference 
{
    object { SupportRangementTournevis_Aluminium } object { TrouSupportRangementTournevis_Aluminium }   
    #for (Identifiant, 0, 15, 4 ) object { TrouRangementTournevis_Aluminium translate <2.5,4,2+Identifiant> } #end 
    translate<1,48,30> scale 2 
}  
 
// Quincaillerie //
// Clou
#declare Clou_RouilleFer = union 
{ 
    object { TeteClou_RouilleFer } 
    object { CorpsClou_RouilleFer }
    object { PointeClou_RouilleFer }   
    translate <78,-4,33> scale 2 rotate z*90
}
#declare Clou_Metal = union 
{ 
    object { TeteClou_Metal } 
    object { CorpsClou_Metal }
    object { PointeClou_Metal }   
    translate <71,-4,25> scale 2 rotate z*90
} 
// Ecrou 
#declare Ecrou = union { difference { object { EcrouHexagone_Metal } object { EcrouHexagone } } translate<260,156,125> scale .5 }
// Rondelle plate
#declare Rondelle = union { object { RondellePlate_Metal } /*scale 2*/ }
 
// Outils //
// Marteau  
#declare Marteau = union
{                                                                
    object { TeteMarteau_Metal rotate x*-90 translate <-2.5,9.6,1> }
    object { MancheMarteau_Frene scale z*.5 } 
    translate <-35,52,2>
    rotate <40,90,40> 
    scale 2.5
}
// Clé plate
#declare ClefPlate = union
{   
    #declare ClePlateFourche = difference { object { ClePlateFourcheCylindre_Metal } object { ClePlateFourcheBox_Metal }  rotate y*10 }                                                             
    object { ClePlateFourche }
    object { ClePlateManche_Metal }
    object { ClePlateFourche translate x*-8.5 rotate y*180 }  
    translate <65,39,25> scale 2
}          
// Burin
#declare Burin = union { object { Burin } translate <-18,-90,52> rotate <90,110,180> scale 1.5 }
// Tournevis
#declare Tournevis = union
{   
    object { TournevisCorps_Metal translate y*3 } 
    object { TournevisEmbout_Metal translate <0,-.3,-15.5> rotate x*90 }                                                              
    object { TournevisManche_OrangeTransparent }    
    translate <-4,-60,33> 
    scale 2 
    rotate z*-180
}  


/* 4 - Mise en scène  */
// Scène // 
object { Etoile_CielNocturne }      
plane { 
    y // Création du sol qui est un vecteur perpendiculaire au plan 
    0 // Hauteur du plan
    material { Chene rotate y*20 } // Texture du sol et son inclinaison
}   
// Décoration //
object { Mur } 
object { Fenetre } 
object { Etagere } 
object { Panneau } 
object { Miroir }
object { Horloge }
object { RamePapier }  
object { Livres }
object { Cendrier }   
object { Cigarette }  
object { MultipriseMurale }
object { RangementTournevis }    
// Quincainllerie //
object { Clou_RouilleFer }   
object { Clou_Metal } 
object { Clou_Metal translate <0,10,34> }  
object { Clou_Metal translate <0,10,41> }  
object { Clou_Metal translate <0,12,-15> }
object { Clou_Metal translate <0,12,-20> }   
//object { Clou_Metal translate<0,-4,41> }
object { Rondelle translate <70,39,33> scale 2 } 
object { Rondelle translate <69.9,39.1,33> scale 2 }   
object { Rondelle translate <70,39.2,33> scale 2 } 
object { Rondelle translate <70.1,39.3,33> scale 2 } 
object { Rondelle translate <70.2,39.4,33> scale 2 }
object { Rondelle translate <70.3,39.5,33> scale 2 } 
object { Ecrou }  
object { Fil_TextureDark translate <-70,65,1> scale 2 rotate y*90 }
object { Fil_TextureDark translate <-70,50,1> scale 2 rotate y*90 }
// Outils //
object { Marteau }
object { ClefPlate }    
object { Burin } 
object { Tournevis }  
object { Tournevis translate z*10 }      
object { Tournevis translate z*20 }  
// Objets blender //
object { bureau scale <-1,1,1>*14.5  translate <-110,0,100>  rotate 90*y material { Chene } }                             
object { chaise scale 25 translate< 65,0,-10> rotate y*-20 }  
object { telephone2 scale 8 translate <-75,78,90> rotate y*45 }
object { vcr scale 8 translate <120,78,-67> rotate y*-40 }   
object { radio2 translate <16,10.8,4> scale 8 }                                                         
object { marteau scale 4 translate <150,3,-28> rotate <0,-180,-90> }   
object { pince scale 5 translate <-5,148,50> rotate y*12 }  
object { torche scale 7 translate <4,150,15> }  
object { K7 scale 4 translate <55,78,80> rotate y*30 }
object { tv scale <-1,1,1>*7 translate <-55,97,60> rotate y*80  }
object { clef scale 7 translate <-65,4,-140> rotate <90,90,0> }
object { lecteur scale 10  translate <-70,78,12> rotate y*90 } 
object { scotch scale 15 translate <20,79,150> }
object { cadenas scale 4 translate <60,78.1,105> rotate y*30 }     