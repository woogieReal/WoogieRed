## Create a Next.js App
---

### ����
``` next
npx create-next-app
```

### ����
```next
npm run dev
```

### ���ο� ������ ����
 * pages ������ ���ο� js ������ ����
   * ex) pages/posts/first-post.js
   * http://localhost:3000/posts/first-post
``` next
export default function FirstPost() { �� �Լ��̸��� ����� ����
    return <h1>First Post</h1>
}
```

## Navigate Between Pages
---
### ����
 * Link ������Ʈ�� Next.js ���� ������ ����  client-side-navigation�� �����ϰ� ��
 * �ڹٽ�ũ��Ʈ�� ���ؼ� ������ ��ȯ�� �ϱ� ������ ������ �⺻ �׺���̼Ǻ��� ������.
 * ������ �̵��ÿ� refresh�� ����.

### import
``` next
import Link from 'next/link'
```

### ����
 * a �±� ��ſ� Link �±׸� ����Ѵ�.
 * a �±״� Link �±� �ȿ��� ��ũ�� �����ش�.
``` next
<h1 className="title">
  Read{' '} �� ' ' ��ĭ�� a�±׿��� ����
  <Link href="/posts/first-post"> 
    <a>this page!</a>
  </Link>
</h1>
```
 * �ε��� �������� ���� ��ũ
``` next
<div className="container">
  <h1>First Post</h1>
  <Link href="/"> �� index��� ���� �ʿ� ����.
    <a>Back to home</a>
  </Link>
</div>
```

### Code Splitting and prefetching
 * Next.js�� code splitting�� **�ڵ�**���� �����Ѵ�.
 * �׷��� �������� render �� �� �ʿ��� ������ �ܿ��� �ʱ�ȭ ���� �ʴ´�.
 * �� �������� isolated �Ǿ��ֱ� ������ �� ���������� ������ ���� ������ ���ø����̼��� �����۵��Ѵ�.
 * Link �±׷� ����� �������� prefetch �Ǳ� ������ ������ �̵��� �� �ִ�.
 
### Note
 * ���� Next.js �� �ܺ��� �������� �����ϰ� �ʹٸ� ������ a �±׸� �̵�
 * a �±��� className �Ӽ��� �̿��ϰ� �ʹٸ� �Ʒ��� ���� ���
``` next
<Link href="/">
  <a className="foo" target="_blank" rel="noopener noreferrer">
    Hello World
  </a>
</Link>
```

## Assets, Metadata, and CSS
---

### ����
 * Next.js �� built-in CSS�� ����

### Assets
 * Next.js�� public ���� �Ʒ��� �̹��� ���� ���� ��Ҹ� ����.
 * public ���� �Ʒ��� ���ϵ��� ���ø����̼ǿ��� �����ȴ�.
 
#### Image

##### ����
 * Next.js�� Image �±״� �ֽ� �������� Ȯ��� next/imageHTML img����̴�.
 * ���������� �����ϴ� ��� JPEG���� �� 30 % ���� **WebP**�� ���� �ֽ� �̹��� �������� �̹����� �ڵ����� �����Ѵ�.(�ʿ信 ���� �̹��� ����ȭ)
 * ����Ʈ�� ��ũ���ϴ� ���� Ư�� �Ӱ� ���� ���� �� ��쿡�� ������ ������ �̹����� �����ε��Ѵ�.
 * �������� ����� �پ��� �� ����� ���� �ػ󵵿� ���� �ٸ� �̹��� ũ�⸦ ������ �� �ִ�.
 * ������ ǰ���� 75 %�� ������ ���� �Ӱ� ������ �ڵ� �����Ѵ�(�� ȣ�⿡ ���� ���� ����)

##### Import
``` next
import Image from 'next/image'
```
##### ���
``` next
<Image
  src="/images/profile.jpg"
  height={144} width={144} alt="woogie"
/>
```

### Metadata

#### Head
 * ����Ʈ������ head �±� ��ſ� Head �±׸� ���

##### Import
``` next
import Head from 'next/head'
```

##### ���
``` next
<Head>
  <title>First Post</title>
</Head>
```

### CSS Styling

#### style jsx

##### style �±�
``` next
<style jsx>{`
  ...
`}</style>
```

#### CSS ���� ���� �� import
 * �ݵ�� �̸��� ���ϸ�.module.css �� ����

##### layout.module.css
``` next
.container {
    max-width: 36rem;
    padding: 0 1rem;
    margin: 3rem auto 6rem;
}
```

##### layout.js
 * className={styles.container}
   * styles�� module.css ������ import�� �� ������ �̸�
   * container�� module.css ���Ͽ��� ������ Ŭ���� ��
``` next
import styles from './layout.module.css'

export default function Layout({ children }) {
  return (
    <div className={styles.container}>
      {children}
    </div>
  )
}
```

##### first-post.js
 * Layout �±� ������ ��ҵ��� layout.js�� default�Լ��� ���� layout�� ���� ä�� ���´�.
``` next
import Layout from '../../components/layout'

export default function FirstPost() {
  return (
  <Layout>
    <Head>
      <title>First Post</title>
    </Head>
    <h1>First Post</h1>
    <Link href="/">
      <a>Back to home</a>
    </Link>
    <Image
      src="/images/profile.jpg"
      height={144} width={144} alt="woogie"
    />
  </Layout>
  )
}
```

#### Global Styles
 * ��� �������� ���� CSS ������ �ε�Ǳ� ���Ѵٸ� ���
 * index.js�� ���� ������ _app.js ����(�̸�����)
   * ���� �Ŀ��� �ݵ�� ������ ������ �ٽ� �÷�����
     * `npm run dev`

##### _app.js
``` next
import '../styles/global.css'

export default function App({ Component, pageProps }) {
  return <Component {...pageProps} />
}	 
```

##### global.css
``` next
html,
body {
  padding: 0;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu,
    Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
  line-height: 1.6;
  font-size: 18px;
}

* {
  box-sizing: border-box;
}

a {
  color: #0070f3;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

img {
  max-width: 100%;
  display: block;
}
```

## Pre-rendering and Data Fetching
---

### Pre-rendering
 * Next.js�� �������� �ε� �Ǹ� ��� �������� pre-render�Ѵ�.
 * ������ HTML�� �ּ����� �ʿ��� �ڹٽ�ũ��Ʈ �ڵ尡 ���ԵǾ� �־� ȭ���� ������ ����.
 * �� �Ŀ� �ڹٽ�ũ��Ʈ�� �۵��ϸ鼭 fully interactive�ϰ� �Ѵ�. 
 * �̸� hydration�̶�� �Ѵ�.
 * Next�� ������� ���� React ���̶�� pre-render�� �������� ����
 * �� ���������� Static Generation �Ǵ� Server-side Rendering�� ���� ����
  
#### Static Generation
 * build time�� HTML�� �����ϰ� ������ request���� ���� �Ǵ� ���
 * �̸� �������� ������ �α� ������ ����ڸ��� �������� generate�� �ʿ䰡 ��������.
 * ��ǰ ������, ��α� �Խù�, ���� ���� ������ �������� ����ϸ� ����.

##### getStaticProps
 * async �Լ��� �ܺ� ���� �ý��ۿ��� �����͸� ������
 * pre-render�ÿ� �����͵� �Բ� render�ϰ� ��
 * �̴� build time�� ���� ���� �����
 * �۵� �ñ�
   * In development (npm run dev or yarn dev), getStaticProps runs on every request.
   * In production, getStaticProps runs at build time. 
 * only be exported from a page. You can��t export it from non-page files.

##### gray-matter
 * ������ ��Ÿ������(ex. title, date ��)�� YAML Front Matter��� �θ���.
 * �̸� parsing �ϱ� ���� ���̺귯���� gray-matter
``` next
npm install gray-matter
```

##### path
 * nextjs-blog
   * lib
     * posts.js
   * pages
     * index.js
   * posts
     * pre-rendering.md
	 * ssg-ssr.md

##### posts.js
``` next
import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

�� process.cwd(): node����� ȣ���� �۾����͸��� ������
�� �Ķ���ͷ� ���� ��ε��� �ϳ��� ���ļ� ���ڿ� ���·� path�� ����
const postsDirectory = path.join(process.cwd(), 'posts')

export function getSortedPostsData() {
  �� /posts ���� �Ʒ��� ���� �̸��� �о����
  const fileNames = fs.readdirSync(postsDirectory)
  
  �� ���ϵ��� �����͸� �о�鿩 Ư�� �����͸� �迭�� ������(map �Լ� ����)
  const allPostsData = fileNames.map(fileName => {
    �� Ȯ���� .md�� ���� �̸��� id�� ��
    const id = fileName.replace(/\.md$/, '')

    �� �����̸��� ������ ��ü��θ� ������ ����
    const fullPath = path.join(postsDirectory, fileName)
	
    �� ������ �����͸� �о� �鿩 ����
    const fileContents = fs.readFileSync(fullPath, 'utf8')

    �� gray-matter�� ����ؼ� metadata section �κ��� �Ľ�
    const matterResult = matter(fileContents)

    �� id ���� gray-matter�� ����� �� ��Ÿ�����͸� ���ļ� ��ȯ
    �� id, title, date
    return {
      id,
      ...matterResult.data
    }
  })
  
  �� ������ ���� ������ �迭�� �ֽ� ������ �����Ͽ� ����
  return allPostsData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}
```

##### index.js
``` next
import Head from 'next/head'
import Layout, { siteTitle } from '../components/layout'
import utilStyles from '../styles/utils.module.css'

�� posts.js�κ��� getSortedPostsData() �Լ��� �ҷ�����
import { getSortedPostsData } from '../lib/posts'

export async function getStaticProps() {

  �� getSortedPostsData() �Լ��� ���� {id, title, date} �����͸� ���Ϲ���
  const allPostsData = getSortedPostsData()
  return {
    props: {
      allPostsData
    }
  }
}

export default function Home({ allPostsData }) {
  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        <p>[Your Self Introduction]</p>
        <p>
          (This is a sample website - you��ll be building a site like this on{' '}
          <a href="https://nextjs.org/learn">our Next.js tutorial</a>.)
        </p>
      </section>

      <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
        <h2 className={utilStyles.headingLg}>Blog</h2>
        <ul className={utilStyles.list}>
          �� allPostsData�� id, date, title ���� �̾� ����Ʈ ���
		  �� utilStyles�� CSS
          {allPostsData.map(({ id, date, title }) => (
            <li className={utilStyles.listItem} key={id}>
              {title}
              <br />
              {id}
              <br />
              {date}
            </li>
          ))}
        </ul>
      </section>
    </Layout>
  )
}
```

##### Fetch External API or Query Database
 * �ܺ� API�� DB�� ���� ������ fetch ����
 * �̰� ������ ������ getStaticProps�� ���� server-side������ �۵��ϱ� ����
 * broweser�� ���� JS bundle���� ���� �ʴ´�.
 * �̴� �������� ���� �� ���� ���� �����ͺ��̽��� ������ �ۼ��ؼ� ������ �� �ִٴ� ��

##### �ڵ� ����
 * �ܺ� API
``` next
export async function getSortedPostsData() {
  �� ���� �ý��� ��ſ� �ܺ� API
  �� fetch post data from an external API endpoint
  const res = await fetch('..')
  return res.json()
}
```
 * DB �����̿�
``` next
import someDatabaseSDK from 'someDatabaseSDK'

const databaseClient = someDatabaseSDK.createClient(...)

export async function getSortedPostsData() {
  �� ���� �ý��� ��ſ� DB
  // fetch post data from a database
  return databaseClient.query('SELECT posts...')
}
```

#### Server-side Rendering
 * ������ request���� generate�Ǵ� ���
 * getServerSideProps ���( <-> getStaticProps)

##### getServerSideProps
 * getServerSideProps�� request time���� �����
 * �Ķ���� context�� request�� �����ڸ� �����ϰ� ����
 * request time�� �����Ͱ� fetch�Ǿ�� �ϴ� ��쿡�� ����ؾ� ��
``` next
export async function getServerSideProps(context) {
  return {
    props: {
      // props for your component
    }
  }
}
```

#### Client-side-Rendering
 * �����͸� pre-render�� �ʿ䰡 ���� ��� ���

##### ����
 1. �ܺ� �����͸� �ʿ�� ���� �ʴ� �������� �κе��� ���� �������� generate��
 2. �������� �ε�Ǹ� Ŭ���̾�Ʈ�� �ڹٽ�ũ��Ʈ�� ����� �ܺε����͸� fetch, �����͸� ������
 
##### ���ó
 * ���������� ���� private�� ������ ��� ���������� ���
 * ����� �����Ͱ� ������Ʈ �Ǿ� request�� ������ ���� �ֽ� �����͸� �ʿ�� �� ��� ���
 
##### SWR
 * Client-side-Rendering �� �� ���
 * caching, revalidation, focus tracking, refetching on interval �� ����
 * �ڼ��� ���� [��ũ����](https://swr.vercel.app/)
``` next
import useSWR from 'swr'

function Profile() {
  const { data, error } = useSWR('/api/user', fetch)

  if (error) return <div>failed to load</div>
  if (!data) return <div>loading...</div>
  return <div>hello {data.name}!</div>
}
```

## Dynamic Routes
---

### 

