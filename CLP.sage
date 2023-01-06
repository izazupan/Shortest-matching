#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import time
import csv


# In[14]:


def generiranje_tock_kvadrat(n):
    # funkcija naključno generira 2n točk v enotskem kvadratu

    V = RDF^2 # vektorski prostor R^2
    tocke = [V.random_element(min=0, max=1) for _ in range(2*n)]
    return tocke


# In[78]:


def generiranje_tock_krog(n):
    # funkcija naključno generira 2n točk v enotskem krogu

    V = RDF^2 # vektorski prostor R^2
    tocke = []
    while len(tocke) < 2*n:
        x = V.random_element(min=-1, max=1)
        if x.norm() <= 1:
            tocke.append(x)
    return tocke


# In[16]:


def generiranje_tock_enakostranicni_trikotnik(n):
    # funkcija naključno generira 2n točk v enakostraničnem trikotniku

    V = RDF^2 # vektorski prostor R^2
    A = Matrix([[1, 1/2], [0, sqrt(3)/2]]) # linearna preslikava
    b = V([1/2, sqrt(3)/6]) # premik, da bo središče trikotnika v izhodišču
    ee = V([1, 1]) # vektor za preslikovanje pod x+y = 1

    tocke = [A*(v if sum(v) < 1 else ee-v) - b for _ in range(2*n) for v in [V.random_element(min=0, max=1)]]
    return tocke


# In[17]:


def graf(n, generiranje_tock, norma=2):
    # funkcija iz naključno generiranih točk ustvari poln graf

    tocke = generiranje_tock(n)
    G = graphs.CompleteGraph(len(tocke))

    for u, v in G.edges(labels=False, sort = False):
        G.set_edge_label(u, v, (tocke[u] - tocke[v]).norm(norma)) # uteži na povezavah so odvisne od razdalj med točkami
    return G


# In[18]:


def dvobarven_graf(n, generiranje_tock, norma=2):
    # funkcija iz naključno generiranih točk ustvari poln dvodelni graf

    tocke = generiranje_tock(n)
    G = graphs.CompleteBipartiteGraph(n, n)

    for u, v in G.edges(labels=False, sort = False):
        G.set_edge_label(u, v, (tocke[u] - tocke[v]).norm(norma)) # uteži na povezavah so odvisne od razdalj med točkami

    return G


# In[19]:


def graf_izris(G):
    # funkcija nariše graf G

    H = Graph([(*e, N(w, digits=2)) for *e, w in G.edges(labels=True, sort = False)])
    H.set_pos(G.get_pos())

    return H.plot(edge_labels=True)


# In[20]:


def clp(G):
    # funkcija izpiše pare vozlišč med katerimi so povezave v najcenejšem prirejanju M, vsoto cen povezav in nariše graf

    p = MixedIntegerLinearProgram(maximization=False)
    b = p.new_variable(binary=True)
    p.set_objective(sum([w * b[Set(e)] for *e, w in G.edges(labels=True, sort = False)])) # upoštevamo uteži povezav

    for v in G: # tukaj nas uteži ne zanimajo
        p.add_constraint(sum([b[Set(e)] for e in G.edges_incident(v, labels=False)]) == 1)

    cena = p.solve() # vrne vrednost ciljne funkcije
    b = p.get_values(b)

    M = [tuple(e) for e, i in b.items() if i]
    print(M)

    # vrne cene povezav v M
    x = [w for *e, w in G.edges(sort = False) if tuple(e) in M] # seznam cen povezav v M
    print(sum(x))

    # izrisovanje
    H = Graph([(*e, N(w, digits=2)) for *e, w in G.edges(labels=True, sort = False)])
    H.set_pos(G.get_pos())

    return H.plot(edge_colors={"red": M}, edge_labels=True) # graf H z rdeče pobarvanimi povezavami iz prirejanja


# In[21]:


def clp_vsota_in_cas(G):
    # funkcija reši clp in vrne minimalno vsoto ter čas ki ga porabi za reševanje clp
    p = MixedIntegerLinearProgram(maximization=False)
    b = p.new_variable(binary=True)
    p.set_objective(sum([w * b[Set(e)] for *e, w in G.edges(labels=True, sort = False)])) # upoštevamo uteži povezav

    start = time.time()
    for v in G: # tukaj nas uteži ne zanimajo
        p.add_constraint(sum([b[Set(e)] for e in G.edges_incident(v, labels=False)]) == 1)

    cena = p.solve() # vrne vrednost ciljne funkcije
    end = time.time()

    b = p.get_values(b)

    M = [tuple(e) for e, i in b.items() if i]

    # vrne cene povezav v M
    x = [w for *e, w in G.edges(sort = False) if tuple(e) in M] # seznam cen povezav v M

    return sum(x), end-start


# In[22]:


def vec_ponovitev(n, lik, stevilo_ponovitev, graf=graf, norma=2):
    q = []
    for i in range(stevilo_ponovitev):
        q.append(clp_vsota_in_cas(graf(n, lik, norma))[0])
    return q


# In[23]:


def casovna_zahtevnost(n, lik, stevilo_ponovitev, graf=graf, norma=2):
    cas = []
    for i in range(stevilo_ponovitev):
        cas.append(clp_vsota_in_cas(graf(n, lik, norma))[1])
    return cas


# In[43]:


def zapis_podatkov(m, n, lik, stevilo_ponovitev, naslov, graf=graf, norma=2):
    podatki = []
    for i in range(m,n+1):
        podatki.append(vec_ponovitev(i, lik, stevilo_ponovitev, graf, norma))
    C = podatki
    with open(naslov, 'w') as f:
        c = csv.writer(f)
        c.writerows(C)


# In[73]:


def zapis_podatkov_cas(m, n, lik, stevilo_ponovitev, naslov, graf=graf, norma=2):
    podatki = []
    for i in range(m,n+1):
        podatki.append(casovna_zahtevnost(i, lik, stevilo_ponovitev, graf, norma))
    C = podatki
    with open(naslov, 'w') as f:
        c = csv.writer(f)
        c.writerows(C)

